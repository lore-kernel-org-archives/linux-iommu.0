From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 0/4 v2] Implement access checks in iommu page fault paths
Date: Tue, 17 Nov 2015 16:11:35 +0100
Message-ID: <1447773099-2444-1-git-send-email-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
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
Cc: David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jesse Barnes <jbarnes-Y1mF5jBUw70BENJcbMCuUQ@public.gmane.org>, Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi,

here is the second version of the patch-set to implement
proper access checks into the io-page-fault handlers of the
AMD IOMMU and Intel VT-d drivers.

Two additional patches clean up the AMD part a bit further.
Since I can't test this this code myself due to lack of
hardware or software that utilizes it, I'd appreciate some
external testing.

It took me a while to get these out, mostly because I tried
to setup my own HSA test environment to at least test the
AMD changes myself. That failed, so I am sending this out
with another request for testing.

Oded, Jesse, would you two please test these patches and
report back? Thanks a lot!


	Joerg

Changes since v1:

	* Updated the access_error functions based on
	  Linus' feedback
	* Rebased to v4.4-rc1

Joerg Roedel (4):
  iommu/amd: Do proper access checking before calling handle_mm_fault()
  iommu/amd: Correctly set flags for handle_mm_fault call
  iommu/amd: Cleanup error handling in do_fault()
  iommu/vt-d: Do access checks before calling handle_mm_fault()

 drivers/iommu/amd_iommu_v2.c | 54 +++++++++++++++++++++++++++-----------------
 drivers/iommu/intel-svm.c    | 20 ++++++++++++++++
 2 files changed, 53 insertions(+), 21 deletions(-)

-- 
1.9.1
