From: "Rafael J. Wysocki" <rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v7 0/3] Cavium ThunderX2 SMMUv3 errata workarounds
Date: Thu, 8 Jun 2017 19:13:24 +0200
Message-ID: <CAJZ5v0gnjxwBXEQ--u6Sbviks74MXLFWTfN+J90cdDZbO2Q7+w@mail.gmail.com>
References: <1496145821-3411-1-git-send-email-gakula@caviumnetworks.com>
	<20170608163213.GA2216@red-moon>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20170608163213.GA2216@red-moon>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>, Lv <lv.zheng-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Charles Garcia Tobin <Charles.Garcia-Tobin-5wv7dgnIgG8@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, linu.cherian-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org, robert.richter-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org, geethasowjanya.akula-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Geetha sowjanya <gakula-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Robert Moore <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ACPI Devel Maling List <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "open list:AMD IOMMU (AMD-VI)" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Sudeep Holla <sudeep.holla-5wv7dgnIgG8@public.gmane.org>, Sunil Goutham <sgoutham-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>, Jon Masters <jcm-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "devel-E0kO6a4B6psdnm+yROfE0A@public.gmane.org" <devel-E0kO6a4B6psdnm+yROfE0A@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Thu, Jun 8, 2017 at 6:32 PM, Lorenzo Pieralisi
<lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org> wrote:
> On Tue, May 30, 2017 at 05:33:38PM +0530, Geetha sowjanya wrote:
>> Cavium ThunderX2 SMMUv3 implementation has two Silicon Erratas.
>> 1. Errata ID #74
>>    SMMU register alias Page 1 is not implemented
>> 2. Errata ID #126
>>    SMMU doesnt support unique IRQ lines and also MSI for gerror,
>>    eventq and cmdq-sync
>>
>> The following patchset does software workaround for these two erratas.
>>
>> This series is based on patchset.
>> https://www.spinics.net/lists/arm-kernel/msg578443.html
>
> Yes so it is not standalone. How are we going to merge these
> ACPI IORT/ACPICA/SMMU patches - inclusive of:
>
> [1] https://www.spinics.net/lists/arm-kernel/msg586458.html
>
> Rafael, do ACPICA patches go upstream via the ACPI tree pull request ?

Not as a rule.

> To remove dependency on ACPICA changes this series needs updating
> anyway and for [1] above I think the only solution is for all the
> patches to go via the ACPI tree (if ACPICA updates go upstream with it).

I think we may ask Lv to backport the header changes once they have
been merged into Linux.

Lv, would that work?

Thanks,
Rafael
