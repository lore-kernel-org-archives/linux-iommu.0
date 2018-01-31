From: Thor Thayer <thor.thayer@linux.intel.com>
Subject: Re: ARM64 SMMU Setup
Date: Wed, 31 Jan 2018 17:31:23 -0600
Message-ID: <2b9c4adb-9645-0c02-ffb6-9357ff421355@linux.intel.com>
References: <fc00c99b-7766-2ac5-83a5-2ed9e13a15e1@linux.intel.com>
 <CAKv+Gu-vwWp_o=XUd17OJ28Brh=Qt_GibpiSMByAXFW07VrxPA@mail.gmail.com>
Reply-To: thor.thayer@linux.intel.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAKv+Gu-vwWp_o=XUd17OJ28Brh=Qt_GibpiSMByAXFW07VrxPA@mail.gmail.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: iommu@lists.linux-foundation.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: iommu@lists.linux-foundation.org

Hi Ard,

On 01/31/2018 04:21 PM, Ard Biesheuvel wrote:
> On 31 January 2018 at 22:09, Thor Thayer <thor.thayer@linux.intel.com> wrote:
>> Hi,
>>
>> I'm enabling the ARM SMMU-500 on an ARM64 A53. I'm hitting a data abort in
>> the probe functions because I'm accessing the registers in EL1 mode.
>>
> 
> Why do you think the fact that you are running at EL1 is causing the data abort?
> 
Yes, I may not be diagnosing this correctly. I narrowed it down to 
failing on the first read in arm_smmu_device_cfg_probe().

When I read the same register with a debugger (I'm in EL1), it fails. I 
just realized the read also fails in EL2.

If I elevate the read to EL3, I can read the default reset value from 
the register but I mistakenly thought this was EL2.


>> Linux starts in EL2 mode but drops down to EL1 mode by the time it reaches
>> the arm-smmu probe function.
>>
>> Is there something else I need to add to either move the arm-smmu probe
>> earlier or remain in EL2 until after the arm-smmu probe?
>>
> 
> No. I am pretty sure EL2 vs EL1 is not causing your issue. Could you
> elaborate on the nature of the exception you are getting?
> 
The error I'm getting is:

Unhandled fault: synchronous external abort (0x96000010) at 
0xffff000008e40020
Internal error: : 96000010 [#1] PREEMPT SMP

To be honest I got lost trying to decode 0x96000010 and I may have used 
the wrong ARM document. I ended up interpreting this as Data Abort taken 
without an Exception level from the ARMv8 ARM.

Additionally, the SMMU documentation seemed to indicate the Hypervisor 
would need to run at EL2 so I ran with that.

Thank you for the reply and I'll go back and examine my assumptions again.

Thor

>> A Google search didn't turn up anything so I hoped posting to the list would
>> help.
>>
>> Thanks in advance,
>>
>> Thor
>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
