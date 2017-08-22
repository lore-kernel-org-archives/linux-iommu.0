From: Oleksandr Tyshchenko <olekstysh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v1] iommu/ipmmu-vmsa: Set context_id to non-existent value
	if allocation failed
Date: Tue, 22 Aug 2017 17:43:07 +0300
Message-ID: <CAPD2p-mioegk+5j-Rac7puQnffT-ERoq2kfxb5rZ3zjqikB0fQ@mail.gmail.com>
References: <1503319241-2912-1-git-send-email-olekstysh@gmail.com>
	<20170822142430.ft6yhl4etx2hhn7h@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20170822142430.ft6yhl4etx2hhn7h-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
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
Cc: laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org, damm+renesas-yzvPICuk2ACczHhG9Qg4qA@public.gmane.org, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Oleksandr Tyshchenko <oleksandr_tyshchenko-uRwfk40T5oI@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi,

On Tue, Aug 22, 2017 at 5:24 PM, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org> wrote:
> On Mon, Aug 21, 2017 at 03:40:41PM +0300, Oleksandr Tyshchenko wrote:
>> From: Oleksandr Tyshchenko <oleksandr_tyshchenko-uRwfk40T5oI@public.gmane.org>
>>
>> In ipmmu_domain_init_context() we are trying to allocate context and
>> if allocation fails we will call free_io_pgtable_ops(),
>> but "domain->context_id" hasn't been initialized yet (likely it is 0
>> because of kzalloc). Having the following call stack:
>> free_io_pgtable_ops() -> io_pgtable_tlb_flush_all() ->
>> ipmmu_tlb_flush_all() -> ipmmu_tlb_invalidate()
>> we will get a mistaken cache flush for a context pointed by
>> uninitialized "domain->context_id".
>>
>> So, set context_id to non-existent value (IPMMU_CTX_MAX) before calling
>> free_io_pgtable_ops() and check it for a valid value (< IPMMU_CTX_MAX)
>> before calling ipmmu_tlb_invalidate().
>>
>> Signed-off-by: Oleksandr Tyshchenko <oleksandr_tyshchenko-uRwfk40T5oI@public.gmane.org>
>> ---
>>  drivers/iommu/ipmmu-vmsa.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>
> Applied, thanks.
Thank you.

>

-- 
Regards,

Oleksandr Tyshchenko
