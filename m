From: Shaohua Li <shli-b10kYP2dOMg@public.gmane.org>
Subject: Re: [PATCH 2/4] iommu: add a bitmap based dma address allocator
Date: Tue, 24 Nov 2015 14:05:12 -0800
Message-ID: <20151124220511.GA2106568@devbig084.prn1.facebook.com>
References: <cover.1448401089.git.shli@fb.com>
	<4c0804c85404be81acfe81fcd402f1af484e9d5f.1448401089.git.shli@fb.com>
	<1448402209.44976.109.camel@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1448402209.44976.109.camel-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: "Woodhouse, David" <david.woodhouse-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "jroedel-l3A5Bk7waGM@public.gmane.org" <jroedel-l3A5Bk7waGM@public.gmane.org>, "Kernel-team-b10kYP2dOMg@public.gmane.org" <Kernel-team-b10kYP2dOMg@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Tue, Nov 24, 2015 at 09:56:50PM +0000, Woodhouse, David wrote:
> On Tue, 2015-11-24 at 13:54 -0800, Shaohua Li wrote:
> > 
> > This patch introduces a bitmap based allocator.
> 
> Why not just use the one in lib/iommu-common.c? I'd like to see
> intel-iommu completely drop the iova.c code.

The lib/iommu-common.c uses a bitmap and a lock. This implementation
actually uses a percpu_ida which completely avoids locking. It would be
possible to make lib/iommu-common.c use percpu_ida too if somebody wants
to do it, but I think this shouldn't be a blocker for these patches
giving it has huge performance gain.

Thanks,
Shaohua
