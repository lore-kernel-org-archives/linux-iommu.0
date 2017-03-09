From: Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v3 06/09] iommu/ipmmu-vmsa: Write IMCTR twice
Date: Thu, 9 Mar 2017 12:57:15 +0900
Message-ID: <CANqRtoQOG=S7s=a+pauF5rU9r-Nch9rcSnvN9utp2ChoA1Trng@mail.gmail.com>
References: <148897088333.16106.13237004440297956899.sendpatchset@little-apple>
	<148897094380.16106.17145886836361556040.sendpatchset@little-apple>
	<fa6696c3-30d0-b7a4-de0b-9cecd485d5a5@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <fa6696c3-30d0-b7a4-de0b-9cecd485d5a5-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Cc: Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux-Renesas <linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Simon Horman <horms+renesas-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Robin,

On Wed, Mar 8, 2017 at 9:34 PM, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org> wrote:
> On 08/03/17 11:02, Magnus Damm wrote:
>> From: Magnus Damm <damm+renesas-yzvPICuk2ACczHhG9Qg4qA@public.gmane.org>
>>
>> Write IMCTR both in the root device and the leaf node.
>>
>> Signed-off-by: Magnus Damm <damm+renesas-yzvPICuk2ACczHhG9Qg4qA@public.gmane.org>
>> ---
>>
>>  Changes since V2:
>>  - None
>>
>>  Changes since V1:
>>  - None
>>
>>  drivers/iommu/ipmmu-vmsa.c |   17 ++++++++++++++---
>>  1 file changed, 14 insertions(+), 3 deletions(-)
>>
>> --- 0018/drivers/iommu/ipmmu-vmsa.c
>> +++ work/drivers/iommu/ipmmu-vmsa.c   2017-03-08 18:30:36.870607110 +0900
>> @@ -286,6 +286,16 @@ static void ipmmu_ctx_write(struct ipmmu
>>       ipmmu_write(domain->root, domain->context_id * IM_CTX_SIZE + reg, data);
>>  }
>>
>> +static void ipmmu_ctx_write2(struct ipmmu_vmsa_domain *domain, unsigned int reg,
>> +                          u32 data)
>
> That's pretty cryptic. Maybe both functions could do with less ambiguous
> names - something like ipmmu_ctx_write_root() vs. ipmmu_ctx_write_all(),
> perhaps? (and if there's a more specific hardware term than "all" that
> describes this kind of configuration, even better).

Yeah I agree. Will fix in next version!

Thanks,

/ magnus
