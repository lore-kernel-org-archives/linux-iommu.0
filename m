From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH] iommu/arm-smmu: fix incorrect use of S2CR_TYPE_SHIFT
Date: Tue, 22 Apr 2014 11:40:52 +0100
Message-ID: <20140422104052.GI7484@arm.com>
References: <1397786874-11372-1-git-send-email-wangkefeng.wang@huawei.com>
	<53508E75.2080703@huawei.com> <20140422100015.GA7484@arm.com>
	<5356441E.3040601@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5356441E.3040601-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Kefeng Wang <wangkefeng.wang-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "guohanjun-hv44wF8Li93QT0dZR+AlfA@public.gmane.org" <guohanjun-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Tue, Apr 22, 2014 at 11:27:42AM +0100, Kefeng Wang wrote:
> On 04/22 18:00, Will Deacon wrote:
> > On Fri, Apr 18, 2014 at 03:31:17AM +0100, Kefeng Wang wrote:
> >> On 04/18 10:07, Kefeng Wang wrote:
> >>> There is already S2CR_TYPE_TRANS in S2CR_TYPE_TRANS macro,
>                      ^^^^^^^^^^^^^^^
> >>> so drop the second shift.
> >>
> >> Typo issue, please use following patch.
> > 
> > They look the same to me -- which one should I take?
> > 
> > Also, since S2CR_TYPE_TRANS is 0x0, this fix isn't critical, so I'll include
> > it in my updates pull for 3.16.
> 
> OK, please use second one, thanks.

Ok, thanks.

Will
