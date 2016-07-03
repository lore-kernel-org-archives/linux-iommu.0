From: Jan Niehusmann <jan-7BUxKyILgIXQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] iommu/vt-d: Fix infinite loop in free_all_cpu_cached_iovas
Date: Sun, 3 Jul 2016 09:53:14 +0200
Message-ID: <20160703075314.GA3128@x61s.reliablesolutions.de>
References: <1467505404-3561-1-git-send-email-aaron@monkey.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1467505404-3561-1-git-send-email-aaron-J6AcJDG0ZEwdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Aaron Campbell <aaron-J6AcJDG0ZEwdnm+yROfE0A@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Sat, Jul 02, 2016 at 09:23:24PM -0300, Aaron Campbell wrote:
> Per VT-d spec Section 10.4.2 ("Capability Register"), the maximum
> number of possible domains is 64K; indeed this is the maximum value
> that the cap_ndoms() macro will expand to.

Good catch. Before 3bd4f9112f87, the loop ended at the fixed value
0xffff. I didn't notice that cap_ndoms() could not only be lower than
that, like on my notebook, but could also be greater. Therefore I didn't
even look at the type of 'did'.

So, strictly speaking, the original code would not only overflow for
small values of cap_ndoms, but would miss the entry at 0xffff in case
cap_ndoms was 0x10000. My patch unfortunately changed that to an endless
loop, instead.

Jan
