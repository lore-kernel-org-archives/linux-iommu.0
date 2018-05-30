From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] iommu/amd - Optimize PPR log handling
Date: Wed, 30 May 2018 06:52:04 +0200
Message-ID: <20180530045203.GO18595@8bytes.org>
References: <152668031618.108078.8188026193559324640.stgit@wsp141332wss.amd.com>
	<20180529145405.GN18595@8bytes.org>
	<223930b9-3df9-813a-6676-68072e4e1bb6@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <223930b9-3df9-813a-6676-68072e4e1bb6-5C7GfCeVMHo@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Gary R Hook <ghook-5C7GfCeVMHo@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Tue, May 29, 2018 at 12:28:54PM -0500, Gary R Hook wrote:
> No, no numbers. We're still working out how best to test this, and
> suggestions/strategies are welcome.

Maybe run a simple kernel on the CPU that does a memcpy on a larger
portion of mmapped (but yet unmapped) process address space and measure
the time it takes for the kernel to run. The page-fault path in the
iommu-driver is only a small part of the involved code here, but maybe
you already see a difference. Doing a u-benchmark only for that code is
probably a bit more challenging.

> The change is modeled after the function iommu_poll_events(), which is much
> cleaner. The GA log handling should be changed, as well (there are
> superfluous writes in the loop), but I figured, "one thing at a time". This
> is admittedly a minor optimization, but discussions with Tom Lendacky have
> led us down this path.
> 
> Your feedback is appreciated.

Yeah, the patch looks good to me from my first review. But since I can't
test that code myself I was wondering if you did any tests and can share
something with me to run my own tests :)



	Joerg
