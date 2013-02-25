From: Andrew Cooks <acooks-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [RFC PATCH] Fix Intel IOMMU support for Marvell 88SE91xx SATA
	controllers.
Date: Mon, 25 Feb 2013 16:37:08 +0800
Message-ID: <CAJtEV7avQcDokktNdziQ+8j+37q7PSbZstxQ09xNWq-6XfAFbw@mail.gmail.com>
References: <1354533387-4110-1-git-send-email-acooks@gmail.com>
	<1355914703-28576-1-git-send-email-acooks@gmail.com>
	<5127C716.6050903@linux-ipv6.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <5127C716.6050903-VfPWfsRibaPZj6PxcwrBaQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Stijn Tintel <stijn-VfPWfsRibaPZj6PxcwrBaQ@public.gmane.org>
Cc: open list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, YingChu <xjtuychu-PkbjNfxxIARBDgjK7y7TUQ@public.gmane.org>, "open list:INTEL IOMMU (VT-d)" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Justin Piszcz <jpiszcz-BP4nVm5VUdNhbmWW9KSYcQ@public.gmane.org>, "open list:PCI SUBSYSTEM" <linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org" <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Sat, Feb 23, 2013 at 3:29 AM, Stijn Tintel <stijn-VfPWfsRibaPZj6PxcwrBaQ@public.gmane.org> wrote:
> On 19-12-12 11:58, Andrew Cooks wrote:
>> This is my second attempt to make Marvell 88SE91xx SATA controllers work when IOMMU is enabled.[1][2]
>> As suggested, it no longer tries to add support for phantom functions.
>>
>> What's missing:
>> * No AMD support. I need some help with this.
>> * Table of affected chip IDs is incomplete. I think 0x9123, 0x9125, 0x9128 are also affected.
> This one is also affected: 08:00.0 0106: 1b4b:9130 (rev 11), this is in
> dmesg:
>
> [    1.914086] dmar: DMAR:[DMA Read] Request device [08:00.1] fault addr
> fff00000

Handling specific chip revisions is another issue I'm not sure how to
handle. We could use another bitmap field, but we need more vendor
cooperation to know exactly which chip model and revision combinations
are affected.

>>
>> Patch is against 3.7.1
>>
>> Review and feedback would be appreciated.
> I changed your patch to check for my chip ID, and it solves my problem:
> no more hang during boot, and the HDD connected to this controller is
> now detected with IOMMU enabled.
>
> Also see 1 minor comment inline.

Thanks for the feedback!  I'll include your PCI_VENDOR_ID change in
the next iteration of the patch.
