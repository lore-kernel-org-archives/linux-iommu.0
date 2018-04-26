From: "ojab //" <ojab-uv7J75MkRmE@public.gmane.org>
Subject: Boot hangs with "AMD-Vi Command Buffer Timeout"
Date: Thu, 26 Apr 2018 10:28:47 +0000
Message-ID: <CAKzrAgQN-qML3-kheKxwAH3aUwny5UNp1vcDKAEEuh0S+4hyTg@mail.gmail.com>
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
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Oh hai!

I've made a bugzilla issue [1] about it, but I'm not sure if anyone
reading bugzilla reports, so duplicating here.
I have raven ridge APU (2400g) + ASUS A320M-K motherboard and boot
(4.16.4 & 4.17-rc2) hangs printing many `[    0.001000] AMD-Vi Command
Buffer Timeout` messages. With IOMMU disabled (either via EFI/BIOS or
using amd_iommu=off) it boots fine.

What info is needed to debug/fix it?

[1] https://bugzilla.kernel.org/show_bug.cgi?id=199513

//wbr ojab
