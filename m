From: Jerome Glisse <jglisse-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 0/2] Optimize mmu_notifier->invalidate_range callback
Date: Wed, 18 Oct 2017 23:08:12 -0400
Message-ID: <20171019030812.GB5246@redhat.com>
References: <20171017031003.7481-1-jglisse@redhat.com>
	<20171019134319.1b856091@MiWiFi-R3-srv>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20171019134319.1b856091@MiWiFi-R3-srv>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Balbir Singh <bsingharora-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Andrea Arcangeli <aarcange-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Stephen Rothwell <sfr-3FnU+UHB4dNDw9hX6IcOSA@public.gmane.org>, Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>, Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, Andrew Donnellan <andrew.donnellan-8fk3Idey6ehBDgjK7y7TUQ@public.gmane.org>, Alistair Popple <alistair-Y4h6yKqj69EXC2x5gXVKYQ@public.gmane.org>, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Michael Ellerman <mpe-Gsx/Oe8HsFggBc27wqDAHg@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Thu, Oct 19, 2017 at 01:43:19PM +1100, Balbir Singh wrote:
> On Mon, 16 Oct 2017 23:10:01 -0400
> jglisse-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org wrote:
> =

> > From: J=E9r=F4me Glisse <jglisse-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> > =

> > (Andrew you already have v1 in your queue of patch 1, patch 2 is new,
> >  i think you can drop it patch 1 v1 for v2, v2 is bit more conservative
> >  and i fixed typos)
> > =

> > All this only affect user of invalidate_range callback (at this time
> > CAPI arch/powerpc/platforms/powernv/npu-dma.c, IOMMU ATS/PASID in
> > drivers/iommu/amd_iommu_v2.c|intel-svm.c)
> > =

> > This patchset remove useless double call to mmu_notifier->invalidate_ra=
nge
> > callback wherever it is safe to do so. The first patch just remove usel=
ess
> > call
> =

> As in an extra call? Where does that come from?

Before this patch you had the following pattern:
  mmu_notifier_invalidate_range_start();
  take_page_table_lock()
  ...
  update_page_table()
  mmu_notifier_invalidate_range()
  ...
  drop_page_table_lock()
  mmu_notifier_invalidate_range_end();

It happens that mmu_notifier_invalidate_range_end() also make an
unconditional call to mmu_notifier_invalidate_range() so in the
above scenario you had 2 calls to mmu_notifier_invalidate_range()

Obviously one of the 2 call is useless. In some case you can drop
the first call (under the page table lock) this is what patch 1
does.

In other cases you can drop the second call that happen inside
mmu_notifier_invalidate_range_end() that is what patch 2 does.

Hence why i am referring to useless double call. I have added
more documentation to explain all this in the code and also under
Documentation/vm/mmu_notifier.txt


> =

> > and add documentation explaining why it is safe to do so. The second
> > patch go further by introducing mmu_notifier_invalidate_range_only_end()
> > which skip callback to invalidate_range this can be done when clearing a
> > pte, pmd or pud with notification which call invalidate_range right aft=
er
> > clearing under the page table lock.
> >
> =

> Balbir Singh.
> =
