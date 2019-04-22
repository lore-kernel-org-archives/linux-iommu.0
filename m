From: Logan Gunthorpe <logang-OTvnGxWRz7hWk0Htik3J/w@public.gmane.org>
Subject: [PATCH v4 08/10] NTB: Add ntb_msi_test support to ntb_test
Date: Mon, 22 Apr 2019 15:05:26 -0600
Message-ID: <20190422210528.15289-9-logang@deltatee.com>
References: <20190422210528.15289-1-logang@deltatee.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20190422210528.15289-1-logang-OTvnGxWRz7hWk0Htik3J/w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-ntb-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kselftest-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jon Mason <jdmason-zqedIHPRSYI@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: Allen Hubbe <allenbh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Dave Jiang <dave.jiang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Serge Semin <fancer.lancer-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Eric Pilmore <epilmore-Op3I1peydIbQT0dZR+AlfA@public.gmane.org>, Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Logan Gunthorpe <logang-OTvnGxWRz7hWk0Htik3J/w@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

When the ntb_msi_test module is available, the test code will trigger
each of the interrupts and ensure the corresponding occurrences files
gets incremented.

Signed-off-by: Logan Gunthorpe <logang-OTvnGxWRz7hWk0Htik3J/w@public.gmane.org>
Cc: Jon Mason <jdmason-zqedIHPRSYI@public.gmane.org>
Cc: Dave Jiang <dave.jiang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Allen Hubbe <allenbh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 tools/testing/selftests/ntb/ntb_test.sh | 54 ++++++++++++++++++++++++-
 1 file changed, 52 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/ntb/ntb_test.sh b/tools/testing/selftests/ntb/ntb_test.sh
index 17ca36403d04..1a10b8f67727 100755
--- a/tools/testing/selftests/ntb/ntb_test.sh
+++ b/tools/testing/selftests/ntb/ntb_test.sh
@@ -87,10 +87,10 @@ set -e
 
 function _modprobe()
 {
-	modprobe "$@"
+	modprobe "$@" || return 1
 
 	if [[ "$REMOTE_HOST" != "" ]]; then
-		ssh "$REMOTE_HOST" modprobe "$@"
+		ssh "$REMOTE_HOST" modprobe "$@" || return 1
 	fi
 }
 
@@ -451,6 +451,30 @@ function pingpong_test()
 	echo "  Passed"
 }
 
+function msi_test()
+{
+	LOC=$1
+	REM=$2
+
+	write_file 1 $LOC/ready
+
+	echo "Running MSI interrupt tests on: $(subdirname $LOC) / $(subdirname $REM)"
+
+	CNT=$(read_file "$LOC/count")
+	for ((i = 0; i < $CNT; i++)); do
+		START=$(read_file $REM/../irq${i}_occurrences)
+		write_file $i $LOC/trigger
+		END=$(read_file $REM/../irq${i}_occurrences)
+
+		if [[ $(($END - $START)) != 1 ]]; then
+			echo "MSI did not trigger the interrupt on the remote side!" >&2
+			exit 1
+		fi
+	done
+
+	echo "  Passed"
+}
+
 function perf_test()
 {
 	USE_DMA=$1
@@ -529,6 +553,29 @@ function ntb_pingpong_tests()
 	_modprobe -r ntb_pingpong
 }
 
+function ntb_msi_tests()
+{
+	LOCAL_MSI="$DEBUGFS/ntb_msi_test/$LOCAL_DEV"
+	REMOTE_MSI="$REMOTE_HOST:$DEBUGFS/ntb_msi_test/$REMOTE_DEV"
+
+	echo "Starting ntb_msi_test tests..."
+
+	if ! _modprobe ntb_msi_test 2> /dev/null; then
+		echo "  Not doing MSI tests seeing the module is not available."
+		return
+	fi
+
+	port_test $LOCAL_MSI $REMOTE_MSI
+
+	LOCAL_PEER="$LOCAL_MSI/peer$LOCAL_PIDX"
+	REMOTE_PEER="$REMOTE_MSI/peer$REMOTE_PIDX"
+
+	msi_test $LOCAL_PEER $REMOTE_PEER
+	msi_test $REMOTE_PEER $LOCAL_PEER
+
+	_modprobe -r ntb_msi_test
+}
+
 function ntb_perf_tests()
 {
 	LOCAL_PERF="$DEBUGFS/ntb_perf/$LOCAL_DEV"
@@ -550,6 +597,7 @@ function cleanup()
 	_modprobe -r ntb_perf 2> /dev/null
 	_modprobe -r ntb_pingpong 2> /dev/null
 	_modprobe -r ntb_transport 2> /dev/null
+	_modprobe -r ntb_msi_test 2> /dev/null
 	set -e
 }
 
@@ -586,5 +634,7 @@ ntb_tool_tests
 echo
 ntb_pingpong_tests
 echo
+ntb_msi_tests
+echo
 ntb_perf_tests
 echo
-- 
2.20.1
