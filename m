From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: AMD-Vi: Event logged [INVALID_DEVICE_REQUEST device=00:14.0
	address=0x000000fdf9103300 flags=0x0600]
Date: Wed, 14 Oct 2015 11:06:49 +0200
Message-ID: <20151014090649.GI27420@8bytes.org>
References: <CADw2B2Mzo2DbMMiyTVjBGVc4-f6Koa6sWQjoLmfX7NZ3B4+saA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CADw2B2Mzo2DbMMiyTVjBGVc4-f6Koa6sWQjoLmfX7NZ3B4+saA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: "G. Richard Bellamy" <rbellamy-1/AleqyZJC8ybS5Ee8rs3A@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Sat, Oct 03, 2015 at 05:19:25PM -0700, G. Richard Bellamy wrote:
> What happens: Kernel logs message to journal, kvm VMs no longer work. Kernel messages spew at a rate of ~660/sec.

The problem is that device 00:14.0 is trying to write to the system
management area and is forbidden to do so by the IOMMU. Can you please
boot with amd_iommu_dump on the kernel command line and send me dmesg?


Thanks,

	Joerg
