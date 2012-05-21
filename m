From: Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 1/2] resources: set type of new resource returned by
	__request_region()
Date: Mon, 21 May 2012 07:52:24 -0600
Message-ID: <CAErSpo582Ok9arr+3krKTQdue4i3wQOixVkBbheDX6a3v8xMHw@mail.gmail.com>
References: <20120518231238.31187.44571.stgit@bhelgaas.mtv.corp.google.com>
	<20120518231832.31187.10630.stgit@bhelgaas.mtv.corp.google.com>
	<20120521130451.GK2313@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20120521130451.GK2313-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Ingo Molnar <mingo-X9Un+BFzKDI@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Suresh Siddha <suresh.b.siddha-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Mon, May 21, 2012 at 7:04 AM, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org> wrote:
> On Fri, May 18, 2012 at 05:18:32PM -0600, Bjorn Helgaas wrote:
>> Previously we returned a new struct resource with only IORESOURCE_BUSY
>> set (and possibly IORESOURCE_MUXED or IORESOURCE_EXCLUSIVE), but no
>> MEM/IO/etc. bits set. =A0The new resource should inherit the type of
>> its parent.
>
> Should it? What about IORESOURCE_WINDOW for example? Any particular
> reason for this change to the interface of the __request_region()
> function?

Yes, I should have explained the connection :)  The next patch prints
the resource returned from request_mem_region().  Without this
__request_region() patch, that resource has no type, so %pR can't
print it correctly.

Good question about IORESOURCE_WINDOW.  Maybe it should inherit only
the IORESOURCE_TYPE_BITS part (IO/MEM/IRQ/DMA/BUS).  But it seemed
like it should also inherit PREFETCH, READONLY, CACHEABLE, etc.  Maybe
we should inherit everything but clear IORESOURCE_WINDOW?  I'm open to
suggestions here.

Bjorn
