From: Suravee Suthikulpanit <Suravee.Suthikulpanit-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH v7 2/7] perf/amd/iommu: Modify functions to query max
	banks and counters
Date: Wed, 11 Jan 2017 10:03:50 +0700
Message-ID: <862635a0-a4fc-066e-0a45-e8626a02775c@amd.com>
References: <1484019227-11473-1-git-send-email-Suravee.Suthikulpanit@amd.com>
	<1484019227-11473-3-git-send-email-Suravee.Suthikulpanit@amd.com>
	<20170110144340.GT17255@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20170110144340.GT17255-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
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
Cc: peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, bp-Gina5bIWoIWzQB+pC5nmwQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org



On 1/10/17 21:43, Joerg Roedel wrote:
> On Mon, Jan 09, 2017 at 09:33:42PM -0600, Suthikulpanit, Suravee wrote:
>> +static struct amd_iommu *get_amd_iommu(uint idx)
>> +{
>> +	uint i = 0;
>> +	struct amd_iommu *iommu = NULL;
>> +
>> +	for_each_iommu(iommu) {
>> +		if (i == idx)
>> +			break;
>> +		i++;
>> +	}
>> +	return iommu;
>> +}
>
> Sorry for missing that in the last review, but this function returns
> just the last iommu in the list when there are less iommus than the
> requested index.
>
> Is that intentional? The following code checks for !iommu, so I guess
> not. It should look more like this then:
>
> 	static struct amd_iommu *get_amd_iommu(uint idx)
> 	{
> 		uint i = 0;
> 		struct amd_iommu *iommu, *ret = NULL;
>
> 		for_each_iommu(iommu)
> 			if (i++ == idx) {
> 				ret = iommu;
> 				break;
> 			}
> 		return ret;
> 	}
>
>
> Regards,
>
> 	Joerg

Right.... Thanks for catching this. Do you want me to send out V8 with 
this fix?

Suravee
