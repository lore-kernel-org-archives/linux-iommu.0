From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [PATCHv7 06/12] ARM: tegra: create a DT header defining SWGROUP ID
Date: Wed, 18 Dec 2013 09:27:29 -0700
Message-ID: <52B1CCF1.2040907@wwwdotorg.org>
References: <1386835033-4701-1-git-send-email-hdoyu@nvidia.com>
	<1386835033-4701-7-git-send-email-hdoyu@nvidia.com>
	<52B1568F.1050305@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <52B1568F.1050305-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Mark Zhang <nvmarkzhang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org
Cc: mark.rutland-5wv7dgnIgG8@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 12/18/2013 01:02 AM, Mark Zhang wrote:
> On 12/12/2013 03:57 PM, Hiroshi Doyu wrote:
>> Create a header file to define the swgroup IDs used by the IOMMU(SMMU)
>> binding. "swgroup" is a group of H/W clients which a Tegra SoC
>> supports. This unique ID can be used to calculate MC_SMMU_<swgroup
>> name>_ASID_0 register offset and MC_<swgroup name>_HOTRESET_*_0
>> register bit. This will allow the same header to be used by both
>> device tree files, and drivers implementing this binding, which
>> guarantees that the two stay in sync. This also makes device trees
>> more readable by using names instead of magic numbers. For HOTRESET
>> bit shifting we need another conversion table, which will come later.

>> diff --git a/include/dt-bindings/memory/tegra-swgroup.h b/include/dt-bindings/memory/tegra-swgroup.h

>> +#define TEGRA_SWGROUP_MPE	11	/* 0x264 */
>> +#define TEGRA_SWGROUP_MSENC	SWGROUP_MPE
> 
> Need to change this to:
> 
> #define TEGRA_SWGROUP_MSENC	11
> 
> The reason is that, this makes "TEGRA_SWGROUP_BIT" doesn't work. So if I
> write "TEGRA_SWGROUP_CELLS(MSENC)" in dt, that causes a dt compiling error.

I guess it's because TEGRA_SWGROUP_BIT needs to expand its argument
twice, which can be done.

That all said, just defining all the names directly to constants is
probably the most direct fix.
