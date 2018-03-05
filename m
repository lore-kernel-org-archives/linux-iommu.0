From: Vivek Gautam <vivek.gautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Using dma-ranges with iommu to limit range of iova
Date: Mon, 5 Mar 2018 14:36:15 +0530
Message-ID: <b2f9355e-7a59-0017-1d84-897e4c8735f2@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi all,

I have a question regarding usage of 'dma-ranges', can someone point me 
in the right direction?
On qcom soc, few of the master devices with iommu attached to them, have 
limitations in using the iova address range. They can allow the iova to 
be only in a certain range, e.g. video codec firmware can only access 
iova only in a first few MBs as the video's arm core reset starts at 0x0.
To do that, I earlier, had the understanding that we can modify the 
iommu_domain's geometry aperture. But that looks kind of a hacky way to 
get the domain for the device and modify the aperture.
I was trying to explore if we can use the dma-ranges property. But the 
iommu bindings documentation doesn't really talks much about usage of 
dma-ranges.
Can someone help me with with the answer to - can we use 'dma-ranges' to 
limit a device's iova address access? If yes, then how?

TIF

Regards
Vivek
