From: Gary R Hook <gary.hook-5C7GfCeVMHo@public.gmane.org>
Subject: Re: Boot hangs with "AMD-Vi Command Buffer Timeout"
Date: Thu, 26 Apr 2018 11:25:05 -0500
Message-ID: <fd019529-d65e-8739-d6d1-4c5d5606dac0@amd.com>
References: <CAKzrAgQN-qML3-kheKxwAH3aUwny5UNp1vcDKAEEuh0S+4hyTg@mail.gmail.com>
	<20180426152233.GP15462@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180426152233.GP15462-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: ojab // <ojab-uv7J75MkRmE@public.gmane.org>
Cc: Tom Lendacky <thomas.lendacky-5C7GfCeVMHo@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 04/26/2018 10:22 AM, Joerg Roedel wrote:
> I've added some AMD people to Cc. Suravee, Tom, any ideas here? One of
> the screen-shots behind the link below show IOTLB_INV_TIMEOUT errors, so
> it is likely ATS related. Maybe you guys can reproduce it on your side?
> 
> 
> Thanks,
> 
> 	Joerg
> 
> 
> On Thu, Apr 26, 2018 at 10:28:47AM +0000, ojab // wrote:
>> I've made a bugzilla issue [1] about it, but I'm not sure if anyone
>> reading bugzilla reports, so duplicating here.
>> I have raven ridge APU (2400g) + ASUS A320M-K motherboard and boot
>> (4.16.4 & 4.17-rc2) hangs printing many `[    0.001000] AMD-Vi Command
>> Buffer Timeout` messages. With IOMMU disabled (either via EFI/BIOS or
>> using amd_iommu=off) it boots fine.
>>
>> What info is needed to debug/fix it?

I realize this is an Asus system, but what BIOS version is on it? Did 
you look to see if an update is available (which I suspect is not, given 
that RR is quite new).

Have you made Asus aware of the problem?

Gary
