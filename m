From: Sinan Kaya <okaya-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [RFC/RFT] Add noats flag to boot parameters
Date: Thu, 3 May 2018 09:46:34 -0400
Message-ID: <359d736a-a7ac-f0e4-f4db-dc7bb506481c@codeaurora.org>
References: <1525025808-2365-1-git-send-email-gilkup@cs.technion.ac.il>
	<20180503133459.waawna3ebtu3udn6@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180503133459.waawna3ebtu3udn6-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
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
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Gil Kupfer <gilkup-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 5/3/2018 9:35 AM, Joerg Roedel wrote:
> On Sun, Apr 29, 2018 at 09:16:48PM +0300, Gil Kupfer wrote:
>> This patch adds noats option to the pci boot parameter.
>> When noats is selected, all ATS related functions fail immediately and
>> the IOMMU is configured to not use device-iotlb.
>>
>> Any function that checks for ATS capabilities directly against the
>> devices should also check this flag. (Currently, such functions exist
>> only in IOMMU drivers, and they are covered by this patch.)
>>
>> The motivation behind this patch is the existence of malicious devices.
>> Lots of research has been done about how to utilitize the IOMMU as a
>> protection from such devices. When ATS is supported, any I/O device can
>> access any physical access by faking device-IOTLB entries.
>> Adding the ability to ignore these entries lets sysadmins enhance system
>> security.
>>
>> Signed-off-by: Gil Kupfer <gilkup-FrESSTt7Abv7r6psnUbsSmZHpeb/A1Y/@public.gmane.org>
> 
> This has also been on my list, thanks for doing that.
> 
> Acked-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
> 

I also like the idea in general.
Minor nit..

Shouldn't this be an iommu parameter rather than a PCI kernel command line parameter?
We now have an iommu.passthrough argument that prevents page translation.

Doesn't this fit into the same category especially when it is the IOMMU drivers that
call ATS functions for enablement not the PCI drivers.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
