From: "Michael S. Tsirkin" <mst-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [RFC 0/2] arm-smmu-v3 tlbi-on-map option
Date: Thu, 13 Jul 2017 20:44:38 +0300
Message-ID: <20170713204107-mutt-send-email-mst@kernel.org>
References: <1499613303-30173-1-git-send-email-eric.auger@redhat.com>
	<20170712175454.GF15191@arm.com>
	<20170712223654-mutt-send-email-mst@kernel.org>
	<fd71a432-0799-3c07-4071-c79bce20a561@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <fd71a432-0799-3c07-4071-c79bce20a561-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
Cc: Marc.Zyngier-5wv7dgnIgG8@public.gmane.org, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, christoffer.dall-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, eric.auger.pro-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Thu, Jul 13, 2017 at 10:29:42AM +0100, Jean-Philippe Brucker wrote:
> On 12/07/17 23:07, Michael S. Tsirkin wrote:
> [...]
> > I think using hardware support for nesting is the right final
> > solution. It will take some time though. Given this, what should
> > we do meanwhile?
> > 
> > Assuming that's the final destination, a simple quirk like this
> > seems to be preferable to virtio-iommu which we'll never be
> > able to offload to hardware.
> 
> That's not entirely true. virtio-iommu will have an extension for hardware
> nesting support. It was presented in my initial proposal, and I've made
> significant progress since then.
> 
> Thanks,
> Jean

I don't recall seeing this.

Hardware specific extensions to virtio would be interesting, the
difficulty is in finding the balance between enabling minor quirks and
each vendor going their own way.

Is this the proposal you refer to?
https://www.spinics.net/lists/kvm/msg147990.html

I couldn't find any mention of nesting, it seems to
say that map requests are relayed through host.

-- 
MST
