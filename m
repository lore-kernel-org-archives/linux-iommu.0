From: "Sumner, William" <bill.sumner-VXdhtT5mjnY@public.gmane.org>
Subject: RE: [PATCHv3 0/6] Crashdump Accepting Active IOMMU
Date: Mon, 10 Mar 2014 19:10:17 +0000
Message-ID: <875D89B79D1D86448A583A7302C022A066E08AFE@G4W3212.americas.hpqcorp.net>
References: <1389391652-52422-1-git-send-email-bill.sumner@hp.com>
	<20140304150611.GE2799@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20140304150611.GE2799-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
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
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: "bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "kexec-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <kexec-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Li, Zhen-Hua" <zhen-hual-VXdhtT5mjnY@public.gmane.org>, "Hatch,
	Douglas B (HPS Linux PM)" <doug.hatch-VXdhtT5mjnY@public.gmane.org>, "ishii.hironobu-+CUm20s59erQFUHtdCDX3A@public.gmane.org" <ishii.hironobu-+CUm20s59erQFUHtdCDX3A@public.gmane.org>, "bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org" <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, "dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org" <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Joerg,

On Tue 3/4/2014 9:06 AM, Joerg Roedel wrote:
>
>On Fri, Jan 10, 2014 at 03:07:26PM -0700, Bill Sumner wrote:
>> Bill Sumner (6):
>>   Crashdump-Accepting-Active-IOMMU-Flags-and-Prototype
>>   Crashdump-Accepting-Active-IOMMU-Utility-functions
>>   Crashdump-Accepting-Active-IOMMU-Domain-Interfaces
>>   Crashdump-Accepting-Active-IOMMU-Copy-Translations
>>   Crashdump-Accepting-Active-IOMMU-Debug-Print-IOMMU
>>   Crashdump-Accepting-Active-IOMMU-Call-From-Mainline
>>
>>  drivers/iommu/intel-iommu.c | 1293
>> ++++++++++++++++++++++++++++++++++++++++---
>>  1 file changed, 1225 insertions(+), 68 deletions(-)
>
>This is a pretty big change, before merging I would like to get more eyes on it. Please make sure you get more reviews on the code and the general concept. A few things I noticed while looking at it:
Yes, as I was developing this, I realized that it is far more code than most Linux submissions.  In addition to more eyes reviewing the code, I hope to see additional members of the community trying it out -- testing it on a wide variety of system configurations.  Let me encourage additional reviewers and testers to look at this fix to crashdump.
>
>* You put a lot of code into #define CONFIG_CRASH_DUMP. Isn't the same approach necessary to for KEXEC?
Until I saw your email, I had been focused only on the immediate problem of fixing crashdump and had not considered using this approach in the more-general context of KEXEC.  It certainly looks like it could be useful with KEXEC as well.  

I would like to take-on the effort of expanding this technique into KEXEC as a separate follow-on project so that the original "fix crashdump" project is not delayed.  On a quick look, I believe that the amount of additional code would be minimal; but the expansion of the testing matrix might be quite large.
>
>* Please get rid of all the pr_debug stuff.
Will do.
>
>* I think it makes sense to put the functions to access the IOMMU
>  configuration values of the old kernel into a new file. This is better
>  than adding over 1000 new lines to intel-iommu.c
Sounds good.  I will move these functions into a new file.
>
>* I have seen your new single-patch for this change. A single patch with
>  more than 1200 changed lines is not something anyone is willing to
>  review. Please split the patches again in a meaningful and bisectable
>  way.
I will return to a multiple-patch set for future submissions.


-- Bill
