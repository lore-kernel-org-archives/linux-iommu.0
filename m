From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [PATCH v2 14/22] iommu/tegra: smmu: Register platform_device
	to IOMMU dynamically
Date: Mon, 29 Jul 2013 11:54:09 -0600
Message-ID: <51F6AC41.30007@wwwdotorg.org>
References: <1373021097-32420-1-git-send-email-hdoyu@nvidia.com><1373021097-32420-15-git-send-email-hdoyu@nvidia.com><51E84D51.2030404@wwwdotorg.org>
	<20130729.142752.1020949402019811407.hdoyu@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20130729.142752.1020949402019811407.hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 07/29/2013 05:27 AM, Hiroshi Doyu wrote:
> Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org> wrote @ Thu, 18 Jul 2013 22:17:21 +0200:
> 
>> On 07/05/2013 04:44 AM, Hiroshi Doyu wrote:
>>> Register platform_devices to IOMMU dynamically via
>>> ops->{add,remove}_device().
>>
>>> diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
>>
>>> +/*
>>> + * ASID[0] for the system default
>>> + * ASID[1] for PPCS, which has SDMMC
>>
>> I have no idea what PPCS is. The patch description for 21/22 implies
>> much more than SDMMC is "in PPCS"...
> 
> "PPCS" is all AHB bus children/(client).

Just to be clear: I was hoping that the comment would be fixed.

>>> + * ASID[2][3].. open for drivers, first come, first served.
>>> + */
>>> +enum {
>>> +	SYSTEM_DEFAULT,
>>> +	SYSTEM_PROTECTED,
>>> +};
>>
>> Why hard-code this mapping? Can't devices be assigned to ASIDs based on
>> a DT property? I assume there's nothing in the SMMU HW that requires
>> specific ASIDs to be used?
> 
> Right. Where should those policy be passed, board DT files?

Is the HW module (== SW group?) to ASID mapping policy or is a
particular mapping required by HW?

Can the ASID mapping just happen dynamically in SW rather than DT
dictating a particular mapping?

I assume the mapping must be set up before any HW is used, and can't be
modified later, so there's no much chance of deferring any policy
decisions to user-space etc.?
