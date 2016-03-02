From: David Kiarie <davidkiarie4-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Bug: Freeing dma regions
Date: Wed, 2 Mar 2016 03:45:39 +0300
Message-ID: <CABdVeACY5dWoj-q4uMUnc-NgqqShemunLU1bbvLpAN6jPdBC+w@mail.gmail.com>
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
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, Valentine Sinitsyn <valentine.sinitsyn-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jan Kiszka <jan.kiszka-S0/GAf8tV78@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hello,

This patch seems to have introduced a bug -
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=4eeca8c5e72fad752eba9efc293c924d65faa86e

As the commit message says, it should check for regions behind the
next_bit but it checks for regions beyond.

David.
