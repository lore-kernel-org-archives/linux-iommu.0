From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v8 3/5] iommu/arm-smmu: Invoke pm_runtime during probe,
	add/remove device
Date: Fri, 9 Mar 2018 17:36:31 +0000
Message-ID: <ae34ca46-8699-bdc7-7d5c-c402e75be97d@arm.com>
References: <20180302101050.6191-1-vivek.gautam@codeaurora.org>
	<20180302101050.6191-4-vivek.gautam@codeaurora.org>
	<d0f2b3ed-136d-7704-2aef-1173a342a89c@arm.com>
	<CAAFQd5BTdF176x5ycatCmCHrMyVX2OZqdXd-JGq06RyDUb0N3g@mail.gmail.com>
	<30a2fa5e-3d8e-acb6-ab31-bec652f1be99@arm.com>
	<CAAFQd5BKkKc2binDe-MCDeP42b6O26Hu9nYjvYRE160EMvi1fA@mail.gmail.com>
	<6fe36177-a8a5-5f17-bf65-1a53538221a4@arm.com>
	<CAAFQd5BU+hU8aPyq6Rcaiwzu1sf7vcRNwnzt5LZZ+L01DnjqhA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <CAAFQd5BU+hU8aPyq6Rcaiwzu1sf7vcRNwnzt5LZZ+L01DnjqhA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Language: en-GB
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Tomasz Figa <tfiga-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, "open list:IOMMU DRIVERS" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-arm-msm <linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

[ +Lorenzo ]

On 09/03/18 04:50, Tomasz Figa wrote:
[...]
>>> Now we need a way to do the check. Perhaps for the time being it would
>>> be enough to just check for the power-domains property in DT?
>>
>>
>> AFAICS, it might be as simple as arm_smmu_probe() doing this:
>>
>>          /*
>>           * We want to avoid touching dev->power.lock in fastpaths unless
>>           * it's really going to do something useful - pm_runtime_enabled()
>>           * can serve as an ideal proxy for that decision.
>>           */
>>          if (dev->pm_domain)
>>                  pm_runtime_enable(dev);
>>
>> or maybe even just gate all the calls with "if (smmu->dev.pm_domain)"
>> directly (like pcie-mediatek does), but I'm not sure which would be
>> conceptually cleaner.
> 
> Okay, that was easier than I expected. Thanks. :)
> 
> Actually, there is one more thing that might need rechecking. Are you
> sure that dev->pm_domain is NULL for the devices, for which we don't
> want runtime PM to be enabled? I think ACPI was mentioned and ACPI
> includes the concept of PM domains.

Thanks for pointing that out - thankfully, I've confirmed that the SMMUs 
on my Juno don't have dev->pm_domain set when booting with ACPI, and 
double-checking the ACPI code I think we're OK here. Since the SMMUs are 
only described in the static IORT table and not in the ACPI namespace, 
they won't have the ACPI companion device that acpi_dev_pm_attach() 
looks for, and thus should always be ignored. Lorenzo, do I have that right?

Robin.
