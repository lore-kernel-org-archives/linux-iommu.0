From: "Li, ZhenHua" <zhen-hual-VXdhtT5mjnY@public.gmane.org>
Subject: Re: [patch] iommu/vt-d: unlock on error in
	intel_iommu_load_translation_tables()
Date: Wed, 03 Jun 2015 13:25:30 +0800
Message-ID: <556E8FCA.6050800@hp.com>
References: <20150602100958.GC11247@mwanda> <20150602134505.GA20381@8bytes.org>
	<20150602140656.GR11734@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20150602140656.GR11734@mwanda>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Dan Carpenter <dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Cc: kernel-janitors-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Li, ZhenHua" <zhen-hual-VXdhtT5mjnY@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Dan,

Do not need to call __iommu_free_mapped_mem() for err_unlock. for
no new elements are added into __iommu_remapped_mem when drops to
err_unlock.


Thanks
Zhenhua

On 06/02/2015 10:06 PM, Dan Carpenter wrote:
> On Tue, Jun 02, 2015 at 03:45:18PM +0200, Joerg Roedel wrote:
>> On Tue, Jun 02, 2015 at 01:09:58PM +0300, Dan Carpenter wrote:
>>> Smatch found some error paths that don't unlock.  Also we can return
>>> -ENOMEM instead of -1 if we don't have an old root entry.
>>>
>>> Fixes: 5908f10af4b9 ('iommu/vt-d: datatypes and functions used for kdump')
>>> Signed-off-by: Dan Carpenter <dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
>>
>> Applied, thanks.
>>
>>> Releasing the lock is good, but we might need to do other error handling
>>> as well.  Presumably this function always succeeds anyway?  It seems
>>> like it might be essential for booting.
>>
>> What do you mean by 'other error handling'? In error case a negative
>> value is returned and the caller checks that.
>
> I was just worried we should call __iommu_free_mapped_mem() or
> something.  I don't know this code very well is what I'm saying...
>
> regards,
> dan carpenter
>
