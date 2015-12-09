From: Tobias Geiger <tobias.geiger-9woOUGhjKTphl2p70BpVqQ@public.gmane.org>
Subject: Regression since 4.1
Date: Wed, 09 Dec 2015 18:01:52 +0100
Message-ID: <5418503.92eb9JWhCR@t400>
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
List-Id: iommu@lists.linux-foundation.org

Hello!

in short:
No Kernel since 4.1 boots on my machine.

I can make newer kernels boot, but ONLY when i remove "iommu=on 
intel_iommu=on" from the cmdline.
If i leave it in, as with all the kernels before and including 4.1, newer 
kernels dont boot, and in a really not very informative way:
They dont even print a single message to the console, i only see the grub-
messages (like "loading kernel" and "loading initial ramdisk") - after these 
messages NO more output of any kind - also no SysRQ keys working - nothing.

Because of this complete lack of information, i guess its hard to debug for 
you the cause of this.
Perhaps i can help - but how?

i'm writing from a pure IOMMU-User perspective - i can compile kernels, but 
never git-bisected, so maybe a hint to a tutorial for that would be great!

Greetings and thanks for your insight!
Tobias
