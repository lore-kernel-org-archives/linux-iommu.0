From: Aaron Sierra <asierra-AQeFf1F/bRxBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH] iova: allow allocation of lowest domain PFN
Date: Thu, 11 May 2017 10:17:10 -0500 (CDT)
Message-ID: <1471909470.267039.1494515830216.JavaMail.zimbra@xes-inc.com>
References: <102275367.137137.1494509795293.JavaMail.zimbra@xes-inc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <102275367.137137.1494509795293.JavaMail.zimbra-AQeFf1F/bRxBDgjK7y7TUQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: iommu <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

----- Original Message -----
> From: "Aaron Sierra" <asierra-AQeFf1F/bRxBDgjK7y7TUQ@public.gmane.org>
> Sent: Thursday, May 11, 2017 8:36:35 AM

> I found it was impossible to allocate all of the address space
> defined by an IOVA domain. For example, a trivial domain with 2 pages
> would cover PFNs 0 (start) and 1 (limit), but attempting to allocate
> more than one total PFN would fail because the start PFN could never be
> allocated.
> 
> This adds a function to prevent PFN limit calculations from dipping
> "below" the start PFN in __alloc_and_insert_iova_range() and
> __get_cached_rbnode(). It also alters the PFN validity checks in
> __alloc_and_insert_iova_range() to anticipate possible PFN rollover.
> These combine to allow every PFN within the IOVA domain to be available
> for allocation.

I should point out that I've understated the impact a bit. In the trivial
example, 1 page isn't just 1 page, it represents half of the available
address space. In less trivial examples, not being able to allocate the
start PFN can prevent a range of any size that would include it. Therefore,
attempting to allocate:

  * all of the address space in one shot will fail
  * the 2nd half of the address space in one shot will fail
  * the 4th quarter of the address space in one shot will fail
  * et cetera

-Aaron S. 

> Signed-off-by: Aaron Sierra <asierra-AQeFf1F/bRxBDgjK7y7TUQ@public.gmane.org>
> ---
> drivers/iommu/iova.c | 43 +++++++++++++++++++++++++++++++------------
> 1 file changed, 31 insertions(+), 12 deletions(-)
