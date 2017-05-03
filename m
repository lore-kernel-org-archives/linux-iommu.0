From: Matthias Ehrenfeuchter <efeu-5Zrl/DuVEGLQT0dZR+AlfA@public.gmane.org>
Subject: AMD Ryzen KVM/NPT/IOMMU issue
Date: Wed, 3 May 2017 16:37:31 +0200
Message-ID: <575f8fbc-0fdc-f336-e3da-53f27da4b2e1@markju.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi,

There are a lot of messages/threads out there about bad performance 
while using AMDs Ryzen with KVM GPU passthrough. It revolves all on 
enabling/disabling npt, while enabled overall VM performance is nice but 
the GPU performance gives me about 20% (and a lot of drops to zero GPU 
usage, while CPU/Disk/Ram also doing nothing) compared to npt disabled. 
But while npt is disabled overall VM performance is like beeing on 4x86 
with floppy disk as only storage. (Ex. it takes 2 seconds just to open 
startmenu while host and vm are in idle, and neither CPU pinning, 
changing CPU model, changing storage device nor using hugepages changed 
anything).

So everything I read pointed to a bug in the npt implementation? 
Anything I could do to get closer to the "thing" issuing this?

Best Regards

efeu
