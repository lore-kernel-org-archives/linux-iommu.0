From: Suravee Suthikulpanit <Suravee.Suthikulpanit-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH V2 0/8] iommu/amd: enable ACPI hardware ID device support
Date: Sat, 5 Mar 2016 16:00:25 +0700
Message-ID: <56DAA029.7040504@amd.com>
References: <1453850077-2539-1-git-send-email-vincent.wan@amd.com>
	<20160226144446.GG22747@8bytes.org>
	<DM3PR1201MB10235E51027C3330C9BAF888E6BE0@DM3PR1201MB1023.namprd12.prod.outlook.com>
	<20160304084624.GA21839@8bytes.org>
	<CY1PR1201MB1019F37D828D88814896B798E6BE0@CY1PR1201MB1019.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <CY1PR1201MB1019F37D828D88814896B798E6BE0-JBJ/M6OpXY8t7t9t4go5W2rFom/aUZj6nBOFsp37pqbUKgpGm//BTAC/G2K4zDHf@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: "Wan, Vincent" <Vincent.Wan-5C7GfCeVMHo@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: "Long, Gang" <Gang.Long-5C7GfCeVMHo@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "Huang, Ray" <Ray.Huang-5C7GfCeVMHo@public.gmane.org>, Borislav Petkov <bp-l3A5Bk7waGM@public.gmane.org>, "Xue, Ken" <Ken.Xue-5C7GfCeVMHo@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Joerg,

On 03/04/2016 03:49 PM, Wan, Vincent wrote:
>>> Joerg,
>>> Can you provide me which branch you are using to test those patches.
>>>
>>> We are validating the patches in v4.5.0-rc6, and no issues like your
>> description.
>>
>> I tested them on v4.5-rc5.
>>
> Thanks!
> We will test the patches basing on this v4.5-rc5 version again.
>
> Vincent.
>>
>> 	Joerg
>

I found the issue now. I'll work with Vincent to send out V3.

The problem is because in the information in the IOMMU Attributes field 
of the IVHD header type 40h (offset byte 20 = struct 
ivhd_header.efr_attr) is incorrect. It was correct in the IVHD type 
10h.... Sigh :(

However, the same information in the MMIO offset 4000h Counter 
configuration Register is correct. So, I'll try to have the patch get 
information from here instead.

Earlier, we had another issue with IOMMU PERF intialization, and it was 
disabled. So, it hides this bug when we were testing the patch earlier.
Now that we had a workaround for that bug n v4.5-rc5, it bombs in the 
init_iommu_perf_ctr().

So, if you want to test out the rest of this patch series, just simply 
comment out this function, and it should boot.

Regards,
Suravee
