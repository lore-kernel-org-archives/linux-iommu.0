From: Jerry Snitselaar <jsnitsel-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: source-id verification failures
Date: Tue, 2 Oct 2018 10:25:29 -0700
Message-ID: <20181002172529.fjapu46h5y57m3f7@cantor>
Reply-To: Jerry Snitselaar <jsnitsel-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

I've been trying to track down a problem where an hp dl380 gen8 with a Cavium QLogic BR-1860 Fabric Adapter
is getting source-id verification failures when running dhclient against that interface. This started showing
up when I backported the iova deferred flushing patches. So far this has only been seen on this one system,
but I'm trying to understand why it appears with the new deferred flushing code. I also see it with both 4.18.10,
and 4.19.0-rc6 kernels.

[35645.282021] bna 0000:24:00.1 ens5f1: link down
[35645.298396] bna 0000:24:00.0 ens5f0: link down
[35650.313210] DMAR: DRHD: handling fault status reg 2
[35650.332477] DMAR: [INTR-REMAP] Request device [24:00.0] fault index 14 [fault reason 38] Blocked an interrupt request due to source-id verification failure
[35655.137667] bna 0000:24:00.0 ens5f0: link up
[35657.532454] bna 0000:24:00.1 ens5f1: link up
[35664.281563] bna 0000:24:00.1 ens5f1: link down
[35664.298103] bna 0000:24:00.0 ens5f0: link down
[35669.313568] DMAR: DRHD: handling fault status reg 102
[35669.333198] DMAR: [INTR-REMAP] Request device [24:00.0] fault index 14 [fault reason 38] Blocked an interrupt request due to source-id verification failure
[35674.081212] bna 0000:24:00.0 ens5f0: link up
[35674.981280] bna 0000:24:00.1 ens5f1: link up


Any ideas?


Regards,
Jerry
