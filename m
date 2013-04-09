From: Suravee Suthikulanit <suravee.suthikulpanit-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH V3] iommu/amd: Add logic to decode AMD IOMMU event flag
Date: Tue, 9 Apr 2013 10:12:13 -0500
Message-ID: <51642FCD.8080606@amd.com>
References: <1364947610-3327-1-git-send-email-suravee.suthikulpanit@amd.com>
	<20130409094132.GD6858@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20130409094132.GD6858-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
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
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 4/9/2013 4:41 AM, Joerg Roedel wrote:
> On Tue, Apr 02, 2013 at 07:06:50PM -0500, Suthikulpanit, Suravee wrote:
>> From: Suravee Suthikulpanit <suravee.suthikulpanit-5C7GfCeVMHo@public.gmane.org>
>>
>> Add logic to decode AMD IOMMU event flag based on information from AMD IOMMU specification.
>> This should simplify debugging IOMMU errors.  Also, dump DTE information in additional cases.
>>
>> This is an example:
>> AMD-Vi: Event logged [IO_PAGE_FAULT device=51:00.0 domain=0x0000 address=0x0000000000000000 flags=0x0fff]
>> AMD-Vi: Flags details: Guest NX=1 User Intr Present Write No-Perm Rsrv-Bit Translation
>> AMD-Vi: Type of error: (0x7)
>> AMD-Vi: (Note: Please refer to AMD IOMMU specification for details.)
>> AMD-Vi: DTE[0]: 6000003fa75e2403
>> AMD-Vi: DTE[1]: 0000000000000014
>> AMD-Vi: DTE[2]: 2000003fa5e09011
>> AMD-Vi: DTE[3]: 0000000000000000
> This example should look like this instead:
>
> AMD-Vi: Event logged [IO_PAGE_FAULT device=51:00.0 domain=0x0000 address=0x0 flags: G NX US I P Wr Rsvd Tr]
>
> by default. When the user passes amd_iommu=verbose on the cmd-line then
> you can print additional information like "type of error" or the dump
> the DTE.
>
>
> 	Joerg
Joerg,

- I can fit DTE dump all in one line (to reduce the number of lines). 
But it is necessary for debugging certain events.
- The "type of error" is also part of the flag translation for certain 
event.  It will only print if it is necessary.
- I can remove the "Note: ... " per Boris's request.
- I can shorten the flag details even more.

Here are some new examples:
[  156.177883] AMD-Vi: Event logged [IO_PAGE_FAULT device=51:00.0 
domain=0x0000 address=0x0000000000000000]
[  156.177895] AMD-Vi: Flags: Gst NX Usr Int P W N-Perm Rsrv Trnslt
[  156.177898] AMD-Vi: Type of error: (0x7)
[  156.177899] AMD-Vi: DTE[0 .. 3]: 6000007fa764f403 0000000000000014 
2000003fabb41811 0000000000000000

[  197.353900] AMD-Vi: Event logged [PAGE_TAB_HARDWARE_ERROR 
device=51:00.0 domain=0x0000 address=0x0000000000000000]
[  197.353917] AMD-Vi: Flags: Gst NX Usr Int P W N-Perm Rsrv Trnslt

These messages are not "high volumn".  What I am trying to achieve is 
for users to be able to just send the errors to developers once they are 
encountered without having to tell them to go back and reboot with the 
"amd_iommu=verbose". In facts, they often difficult to reproduce from my 
experience.  This should reduce the amount of communications and efforts 
required to debug the issue.

If you are ok with this, I will send out V4 in the next email.

Thank you,

Suravee
