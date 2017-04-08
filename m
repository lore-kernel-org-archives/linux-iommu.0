From: Nick Sarnie <commendsarnex-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: AMD Nested Paging Performance Issues
Date: Sat, 8 Apr 2017 02:11:26 -0400
Message-ID: <CAOcCaLZ+6z8RdUH4Fh1R1J=QQxBWbTEeG6f7sFdfS-D+BRsSTg@mail.gmail.com>
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
Cc: Alexander.Deucher-5C7GfCeVMHo@public.gmane.org, Arindam.Nath-5C7GfCeVMHo@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi all,

Myself and many community members have noticed an issue when enabling
Nested Page Tables in a VM which uses GPU Passthrough on AMD CPUs. I
have found that NPT universally increases CPU performance when it is
enabled, but it destroys passed-through GPU performance by around two
to three times depending on the application. For example, my Dota 2
FPS with NPT enabled is around 30 FPS, where as it is around 110 FPS
with NPT disabled.  This has been reproduced by myself on both Linux
and Windows VMs, is widely reported in the VFIO community, and Alex
Williamson told me that he was able to reproduce the issue on both AMD
and Nvidia GPUs, but isn't sure of the cause.

Because of this, we are forced to disable NPT if we want to have any
sort of reasonable GPU performance, which in turn causes CPU
performance issues.

Please let me know if you have any ideas on this issue, I can test any
patches or provide any more information.

Thank you,
Nick Sarnie
