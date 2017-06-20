From: Ganapatrao Kulkarni <gpkulkarni@gmail.com>
Subject: Re: [PATCH v3 1/2] acpica: iort: Update SMMUv3 header for proximity
 domain mapping
Date: Tue, 20 Jun 2017 07:57:09 +0530
Message-ID: <CAFpQJXVE8pfmbn5b+5ngiJ01OVLH-pLn7zhpzWX2+62SR1L_qA@mail.gmail.com>
References: <1496897059-8272-1-git-send-email-ganapatrao.kulkarni@cavium.com>
 <1496897059-8272-2-git-send-email-ganapatrao.kulkarni@cavium.com> <0d0d6cb6-7674-5751-d780-af5114ddd569@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <0d0d6cb6-7674-5751-d780-af5114ddd569@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Robin Murphy <robin.murphy@arm.com>
Cc: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-acpi@vger.kernel.org, iommu@lists.linux-foundation.org, Will Deacon <Will.Deacon@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Hanjun Guo <hanjun.guo@linaro.org>, sudeep.holla@arm.com, Lv Zheng <lv.zheng@intel.com>, joro@8bytes.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Jayachandran C <jnair@caviumnetworks.com>
List-Id: iommu@lists.linux-foundation.org

On Mon, Jun 19, 2017 at 11:24 PM, Robin Murphy <robin.murphy@arm.com> wrote:
> On 08/06/17 05:44, Ganapatrao Kulkarni wrote:
>> ARM IORT specification (rev. C) has added two new fields to define
>> proximity domain for the SMMUv3 node in the IORT table.
>>
>> Proximity Domain Valid:
>>       Set to 1 if the value provided in the Proximity Domain field is
>>       valid. Set to 0 otherwise.
>>
>> Proximity domain:
>>       If the Proximity Domain Valid flag is set to 1, this entry
>>       provides the proximity domain to which this SMMU
>>       instance belongs.
>>
>> Update header file to reflect this.
>>
>> Signed-off-by: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
>> ---
>>  include/acpi/actbl2.h | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
>> index 4b306a6..389e91f 100644
>> --- a/include/acpi/actbl2.h
>> +++ b/include/acpi/actbl2.h
>> @@ -805,6 +805,9 @@ struct acpi_iort_smmu_v3 {
>>       u32 pri_gsiv;
>>       u32 gerr_gsiv;
>>       u32 sync_gsiv;
>> +     u8 pxm;
>> +     u8 reserved1;
>> +     u16 reserved2;
>
> Why add the padding if you're not also adding the following field that
> it aligns? (side note: could it not just be a u8[3]?)

added to align as well to comply with  the spec.

>
> If the actual structure definition is changing, do there not need to be
> corresponding IASL changes too?

yes, it is been added and sent to acpica devel ML.
https://lists.acpica.org/pipermail/devel/2017-June/001243.html

>
>>  };
>>
>>  /* Values for Model field above */
>> @@ -817,6 +820,7 @@ struct acpi_iort_smmu_v3 {
>>
>>  #define ACPI_IORT_SMMU_V3_COHACC_OVERRIDE   (1)
>>  #define ACPI_IORT_SMMU_V3_HTTU_OVERRIDE     (1<<1)
>> +#define ACPI_IORT_SMMU_V3_PXM_VALID         (1<<3)
>
> Maybe it's just me, but "PXM" seems incredibly cryptic.

PXM stands for proximity(refer ACPI spec)
it is widely used in spec and also in Linux kernel.

>
> Robin.
>
>>
>>  /*******************************************************************************
>>   *
>>
>

thanks
Ganapat
