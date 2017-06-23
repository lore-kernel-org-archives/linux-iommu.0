From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v2 0/8] io-pgtable lock removal
Date: Fri, 23 Jun 2017 10:58:38 +0100
Message-ID: <f694a247-9006-3a3c-8a77-209b158eabf3@arm.com>
References: <cover.1498145008.git.robin.murphy@arm.com>
	<61b7b953-5bf4-eb45-c3e8-b4491e8fdca7@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <61b7b953-5bf4-eb45-c3e8-b4491e8fdca7-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
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
To: John Garry <john.garry-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, will.deacon-5wv7dgnIgG8@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org
Cc: sunil.goutham-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org, thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, wangzhou1-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org, Linuxarm <linuxarm-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, ray.jui-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linu.cherian-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 23/06/17 09:47, John Garry wrote:
> On 22/06/2017 16:53, Robin Murphy wrote:
>> The feedback has been promising, so v2 is just a final update to cover
>> a handful of memory ordering and cosmetic tweaks that came up when Will
>> and I went through this offline.
>>
>> Thanks,
>> Robin.
> 
> Hi Robin,
> 
> Is it worth us retesting this patchset?
> 
> If yes, as for a branch (for convenience), does this one now match v2:
> git://linux-arm.org/linux-rm  iommu/pgtable
> 
> I saw it was rewritten recently.

Indeed, I pushed the branch out before posting. Functionally it ought to
be identical to v1, so this was more just a heads-up - feel free to
double-check I've not broken anything, but I wouldn't say you need to
throw the full test lab at it again.

Thanks,
Robin.

> 
> Thanks,
> John
> 
>>
>>
>> Robin Murphy (8):
>>   iommu/io-pgtable-arm-v7s: Check table PTEs more precisely
>>   iommu/io-pgtable-arm: Improve split_blk_unmap
>>   iommu/io-pgtable-arm-v7s: Refactor split_blk_unmap
>>   iommu/io-pgtable: Introduce explicit coherency
>>   iommu/io-pgtable-arm: Support lockless operation
>>   iommu/io-pgtable-arm-v7s: Support lockless operation
>>   iommu/arm-smmu: Remove io-pgtable spinlock
>>   iommu/arm-smmu-v3: Remove io-pgtable spinlock
>>
>>  drivers/iommu/arm-smmu-v3.c        |  36 ++-----
>>  drivers/iommu/arm-smmu.c           |  48 ++++------
>>  drivers/iommu/io-pgtable-arm-v7s.c | 179
>> +++++++++++++++++++++-------------
>>  drivers/iommu/io-pgtable-arm.c     | 191
>> ++++++++++++++++++++++++-------------
>>  drivers/iommu/io-pgtable.h         |   6 ++
>>  5 files changed, 274 insertions(+), 186 deletions(-)
>>
> 
> 
