From: yanxiaofeng <yanxiaofeng-6gUaA8visnnQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] intel_irq_remapping: fix a comment error
Date: Wed, 3 Jun 2015 16:30:50 +0800
Message-ID: <556EBB3A.2030608@inspur.com>
References: <1433319615-29776-1-git-send-email-yanxiaofeng@inspur.com>
	<556EB9F2.4040408@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4568128723272337174=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <556EB9F2.4040408-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

--===============4568128723272337174==
Content-Type: multipart/alternative;
	boundary="------------070209070100070001010102"

--------------070209070100070001010102
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable



=E5=9C=A8 2015=E5=B9=B406=E6=9C=8803=E6=97=A5 16:25, Jiang Liu =E5=86=99=E9=
=81=93:
> On 2015/6/3 16:20, xiaofeng.yan wrote:
>> change tabke to take.
>>
>> Signed-off-by: xiaofeng.yan <yanxiaofeng-6gUaA8visnnQT0dZR+AlfA@public.gmane.org>
>> ---
>>   drivers/iommu/intel_irq_remapping.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/iommu/intel_irq_remapping.c b/drivers/iommu/intel=
_irq_remapping.c
>> index 5709ae9..d59f82d 100644
>> --- a/drivers/iommu/intel_irq_remapping.c
>> +++ b/drivers/iommu/intel_irq_remapping.c
>> @@ -46,7 +46,7 @@ static struct hpet_scope ir_hpet[MAX_HPET_TBS];
>>    *	->iommu->register_lock
>>    * Note:
>>    * intel_irq_remap_ops.{supported,prepare,enable,disable,reenable} a=
re called
>> - * in single-threaded environment with interrupt disabled, so no need=
 to tabke
>> + * in single-threaded environment with interrupt disabled, so no need=
 to take
>>    * the dmar_global_lock.
>>    */
>>   static DEFINE_RAW_SPINLOCK(irq_2_ir_lock);
>> @@ -185,6 +185,7 @@ static int modify_irte(int irq, struct irte *irte_=
modified)
>>   		return -1;
>>  =20
>>   	raw_spin_lock_irqsave(&irq_2_ir_lock, flags);
>> +	while(1):
> Hi Xiaofeng,
> 	Seems above change be removed.
Yes, Thank you for your correction.
I will send correctional patch.

Thanks
Yan
> Thanks!
> Gerry
>
>>  =20
>>   	iommu =3D irq_iommu->iommu;
>>  =20
>>
> .
>


--------------070209070100070001010102
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<html>
  <head>
    <meta content=3D"text/html; charset=3DUTF-8" http-equiv=3D"Content-Ty=
pe">
  </head>
  <body bgcolor=3D"#FFFFFF" text=3D"#000000">
    <br>
    <br>
    <div class=3D"moz-cite-prefix">=E5=9C=A8 2015=E5=B9=B406=E6=9C=8803=E6=
=97=A5 16:25, Jiang Liu =E5=86=99=E9=81=93:<br>
    </div>
    <blockquote cite=3D"mid:556EB9F2.4040408-VuQAYsv1563Yd54FQh9/CA@public.gmane.org" type=3D"cit=
e">
      <pre wrap=3D"">On 2015/6/3 16:20, xiaofeng.yan wrote:
</pre>
      <blockquote type=3D"cite">
        <pre wrap=3D"">change tabke to take.

Signed-off-by: xiaofeng.yan <a class=3D"moz-txt-link-rfc2396E" href=3D"ma=
ilto:yanxiaofeng-6gUaA8visnnQT0dZR+AlfA@public.gmane.org">&lt;yanxiaofeng-6gUaA8visnnQT0dZR+AlfA@public.gmane.org&gt;</a>
---
 drivers/iommu/intel_irq_remapping.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/intel_irq_remapping.c b/drivers/iommu/intel_ir=
q_remapping.c
index 5709ae9..d59f82d 100644
--- a/drivers/iommu/intel_irq_remapping.c
+++ b/drivers/iommu/intel_irq_remapping.c
@@ -46,7 +46,7 @@ static struct hpet_scope ir_hpet[MAX_HPET_TBS];
  *	-&gt;iommu-&gt;register_lock
  * Note:
  * intel_irq_remap_ops.{supported,prepare,enable,disable,reenable} are c=
alled
- * in single-threaded environment with interrupt disabled, so no need to=
 tabke
+ * in single-threaded environment with interrupt disabled, so no need to=
 take
  * the dmar_global_lock.
  */
 static DEFINE_RAW_SPINLOCK(irq_2_ir_lock);
@@ -185,6 +185,7 @@ static int modify_irte(int irq, struct irte *irte_mod=
ified)
 		return -1;
=20
 	raw_spin_lock_irqsave(&amp;irq_2_ir_lock, flags);
+	while(1):
</pre>
      </blockquote>
      <pre wrap=3D"">Hi Xiaofeng,
	Seems above change be removed.</pre>
    </blockquote>
    Yes, <span style=3D"cursor: pointer;">Thank you for your correction.<=
br>
      I will send correctional patch.<br>
      <br>
      Thanks<br>
      Yan<br>
    </span>
    <blockquote cite=3D"mid:556EB9F2.4040408-VuQAYsv1563Yd54FQh9/CA@public.gmane.org" type=3D"cit=
e">
      <pre wrap=3D"">
Thanks!
Gerry

</pre>
      <blockquote type=3D"cite">
        <pre wrap=3D"">=20
 	iommu =3D irq_iommu-&gt;iommu;
=20

</pre>
      </blockquote>
      <pre wrap=3D"">.

</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------070209070100070001010102--

--===============4568128723272337174==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4568128723272337174==--
