From: lijiang <lijiang@redhat.com>
Subject: Re: [PATCH 2/5 V6] x86/ioremap: strengthen the logic in
 early_memremap_pgprot_adjust() to adjust encryption mask
Date: Mon, 3 Sep 2018 22:06:19 +0800
Message-ID: <d2229538-51d5-ead7-c7e5-f4afe5b53693@redhat.com>
References: <20180831081930.31561-1-lijiang@redhat.com>
 <20180831081930.31561-3-lijiang@redhat.com>
 <20180903024512.GA2568@dhcp-128-65.nay.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180903024512.GA2568@dhcp-128-65.nay.redhat.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Dave Young <dyoung@redhat.com>
Cc: linux-kernel@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de, hpa@zytor.com, ebiederm@xmission.com, joro@8bytes.org, thomas.lendacky@amd.com, kexec@lists.infradead.org, iommu@lists.linux-foundation.org, bhe@redhat.com
List-Id: iommu@lists.linux-foundation.org

在 2018年09月03日 10:45, Dave Young 写道:
> On 08/31/18 at 04:19pm, Lianbo Jiang wrote:
>> For kdump kernel, when SME is enabled, the acpi table and dmi table will need
>> to be remapped without the memory encryption mask. So we have to strengthen
>> the logic in early_memremap_pgprot_adjust(), which makes us have an opportunity
>> to adjust the memory encryption mask.
>>
>> Signed-off-by: Lianbo Jiang <lijiang@redhat.com>
>> ---
>>  arch/x86/mm/ioremap.c | 9 ++++++++-
>>  1 file changed, 8 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
>> index e01e6c695add..f9d9a39955f3 100644
>> --- a/arch/x86/mm/ioremap.c
>> +++ b/arch/x86/mm/ioremap.c
>> @@ -689,8 +689,15 @@ pgprot_t __init early_memremap_pgprot_adjust(resource_size_t phys_addr,
>>  	encrypted_prot = true;
>>  
>>  	if (sme_active()) {
>> +                /*
>> +                 * In kdump kernel, the acpi table and dmi table will need
>> +                 * to be remapped without the memory encryption mask. Here
>> +                 * we have to strengthen the logic to adjust the memory
>> +                 * encryption mask.
> 
> Assume the acpi/dmi tables are identical for both 1st kernel and kdump
> kernel, I'm not sure what is the difference, why need special handling
> for kdump. Can you add more explanations?
> 

Ok, i will use a dmi example to explain this issue.

There are significant differences about E820 between the 1st kernel and kdump kernel. I pasted them at bottom.

Firstly, we need to know how they are called.
__acpi_map_table()\                                                        / early_memremap_is_setup_data()
                   |-> early_memremap()-> early_memremap_pgprot_adjust()-> | memremap_is_efi_data()
 dmi_early_remap()/                                                        \ memremap_should_map_decrypted()-> e820__get_entry_type()

Secondly, we also need to understand the memremap_should_map_decrypted(), which is illustrated by the fake code.
static bool memremap_should_map_decrypted(resource_size_t phys_addr,
                                          unsigned long size)
{

    /* code ... */

    switch (e820__get_entry_type(phys_addr, phys_addr + size - 1)) {
        case E820_TYPE_RESERVED:
        case E820_TYPE_ACPI:
        case E820_TYPE_NVS:
        case E820_TYPE_UNUSABLE:
                /* For SEV, these areas are encrypted */
                if (sev_active())
                        break;
                /* Fallthrough */

        case E820_TYPE_PRAM:
                /* For SME, these areas are decrypted */
                return true;
        default:
                /* these areas are encrypted by default*/
                break;
    }

    return false;
}

For the dmi case, the dmi base address is 0x6286b000 in my test machine.

In the 1st kernel, the e820__get_entry_type() can get a valid entry and type by the dmi address, and we can also find the dmi base address from e820.
(see the 1st kernel log)
0x6286b000 ∈ [mem 0x000000006286b000-0x000000006286efff]
So, these areas are decrypted according to the memremap_should_map_decrypted().

In kdump kernel, the dmi base address is still 0x6286b000, but we can not find the dmi base address from e820 any more. The e820__get_entry_type() can
not get a valid entry and type by the dmi base address, it will go into the default branch. That is to say, these areas become encrypted. In fact, these
areas are also decrypted, so we have to strengthen the logic of adjusting the memory encryption mask.


The 1st kernel log:

[    0.000000] BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000008bfff] usable
[    0.000000] BIOS-e820: [mem 0x000000000008c000-0x000000000009ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000000e0000-0x00000000000fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x0000000029920fff] usable
[    0.000000] BIOS-e820: [mem 0x0000000029921000-0x0000000029921fff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000029922000-0x0000000062256fff] usable
[    0.000000] BIOS-e820: [mem 0x0000000062257000-0x0000000062356fff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000062357000-0x000000006235cfff] ACPI data
[    0.000000] BIOS-e820: [mem 0x000000006235d000-0x00000000623dbfff] usable
[    0.000000] BIOS-e820: [mem 0x00000000623dc000-0x000000006261bfff] reserved
[    0.000000] BIOS-e820: [mem 0x000000006261c000-0x000000006263dfff] usable
[    0.000000] BIOS-e820: [mem 0x000000006263e000-0x000000006269dfff] reserved
[    0.000000] BIOS-e820: [mem 0x000000006269e000-0x00000000627d6fff] usable
[    0.000000] BIOS-e820: [mem 0x00000000627d7000-0x00000000627e3fff] ACPI data
[    0.000000] BIOS-e820: [mem 0x00000000627e4000-0x00000000627e4fff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x00000000627e5000-0x00000000627e8fff] ACPI data
[    0.000000] BIOS-e820: [mem 0x00000000627e9000-0x00000000627eafff] usable
[    0.000000] BIOS-e820: [mem 0x00000000627eb000-0x00000000627ebfff] ACPI data
[    0.000000] BIOS-e820: [mem 0x00000000627ec000-0x000000006286afff] usable
[    0.000000] BIOS-e820: [mem 0x000000006286b000-0x000000006286efff] reserved
[    0.000000] BIOS-e820: [mem 0x000000006286f000-0x00000000682f8fff] usable
[    0.000000] BIOS-e820: [mem 0x00000000682f9000-0x0000000068b05fff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000068b06000-0x0000000068b09fff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x0000000068b0a000-0x0000000068b1afff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000068b1b000-0x0000000068b1dfff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x0000000068b1e000-0x0000000071d1dfff] usable
[    0.000000] BIOS-e820: [mem 0x0000000071d1e000-0x0000000071d2dfff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000071d2e000-0x0000000071d3dfff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x0000000071d3e000-0x0000000071d4dfff] ACPI data
[    0.000000] BIOS-e820: [mem 0x0000000071d4e000-0x0000000077ffffff] usable
[    0.000000] BIOS-e820: [mem 0x0000000078000000-0x000000008fffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed80000-0x00000000fed80fff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000087effffff] usable
[    0.000000] BIOS-e820: [mem 0x000000087f000000-0x000000087fffffff] reserved

The kdump kernel log:

[    0.000000] BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000001000-0x000000000008bfff] usable
[    0.000000] BIOS-e820: [mem 0x0000000052000000-0x0000000061ffffff] usable
[    0.000000] BIOS-e820: [mem 0x00000000622ee000-0x0000000062300fff] ACPI data
[    0.000000] BIOS-e820: [mem 0x0000000062301000-0x0000000062301fff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x0000000062703000-0x0000000062703fff] ACPI data
[    0.000000] BIOS-e820: [mem 0x0000000062735000-0x0000000062737fff] ACPI data
[    0.000000] BIOS-e820: [mem 0x000000006273a000-0x000000006273afff] ACPI data
[    0.000000] BIOS-e820: [mem 0x0000000068b06000-0x0000000068b09fff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x0000000068b1b000-0x0000000068b1dfff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x0000000071d2e000-0x0000000071d3dfff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x0000000071d3e000-0x0000000071d4dfff] ACPI data
[    0.000000] BIOS-e820: [mem 0x00000007fe000000-0x000000087df70fff] usable

>> +                 */
>>  		if (early_memremap_is_setup_data(phys_addr, size) ||
>> -		    memremap_is_efi_data(phys_addr, size))
>> +		    memremap_is_efi_data(phys_addr, size) ||
>> +		    is_kdump_kernel())
>>  			encrypted_prot = false;
>>  	}
>>  
>> -- 
>> 2.17.1
>>
> 
> Thanks
> Dave
> 
