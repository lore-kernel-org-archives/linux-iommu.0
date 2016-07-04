From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
Subject: Re: [PATCH] iommu/vt-d: Fix infinite loop in free_all_cpu_cached_iovas
Date: Mon, 4 Jul 2016 13:37:11 +0200
Message-ID: <20160704113527.GD11467@suse.de>
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
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Sat, Jul 02, 2016 at 09:23:24PM -0300, Aaron Campbell wrote:
> Per VT-d spec Section 10.4.2 ("Capability Register"), the maximum
> number of possible domains is 64K; indeed this is the maximum value
> that the cap_ndoms() macro will expand to.  Since the value 65536
> will not fix in a u16, the 'did' variable must be promoted to an
> int, otherwise the test for < 65536 will always be true and the
> loop will never end.
> 
> The symptom, in my case, was a hung machine during suspend.

Applied, thanks.
