Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013060.outbound.protection.outlook.com [40.107.162.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1892E21A42D
	for <iommu@lists.linux.dev>; Thu,  8 Oct 2026 13:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791467115; cv=fail; b=B8Wb4z0jk0jlG9f/FKvhvX45vrrYODFSkZVPCjtx4qM8TY2ESeFXFaw4UEX0BoQ9twm0ARqTbuzEn9waP0KnNkxD5f5xM9ncGTDlVoNp9RxE6BPl+MvLYGCblHzl/C+IS+GIjBY6ZjD+kKkYPBvbs3QJXbkn4h7QM0An4WE9O9A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791467115; c=relaxed/simple;
	bh=2PGQPhLq5muBnpp4KH3RSbOrOmbVCaXr6ZOxvv/eLmk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YJJLPZNUwTCzgmIJetDLGz+risDOoX0fasaY2OSZ1lBD5bMZlslLufz3Zr/krtkOW+5N7dvwBqWhJp5xZBYXAQgcBZWv37jdB53ClctLWPqVOnFV5rWTwPp/gwpEsp2WZdkmRYXCPBQ61WHSsJ1hEikHOZO7JNLBrvAHTZ9Xw7k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=IxfVNekH; arc=fail smtp.client-ip=40.107.162.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="IxfVNekH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K1bM54R5RRCQmJVbqrwtJXBf3nDBkvWqCkA9AzBx63I5p7qpVhb31uNwCz+ctu7zJZVP1LPNdJaXYhXZ3TCPPMVT2R7dJIfE4e4b4/hKt9q3q6ww/RxLz+PrUG2xuK1c0O7qDySwDkYCO0HG7bbuRYIXTCifa1tVPNX7m1/q612oDDE54hoJWCaFupUtR3IdfDvQDO477hmuexPYOeXY6HdpZwpg0yfiOzwKWAD4Sl7/V7WUsTAFivker9CfOKMDheS2abE+Lc18VPS44hcvSrmZwQ3kKDw+bGbLMVExu3rHQQ+1BrL6ulyyfx23WJeCqXcjcILHUCSvTJXzxcLU1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=38dQtDKrsCUzk4mZVkf2drMOrhwH/LU2xnSYRAGDjss=;
 b=hNIgF2LhqBAcNZ8gakyK+W/1ikDqcffNjw+jbN6vU4dHhyc1duv+pmpGaBXpjWNHQEIKScCfYWqixktP9pDETJ3niGmrQLgp0JKRjDxknIMztyi7uXwPPYrd7gq8q8lsp7dEPbvnRh/957KH/PdUdHD90W+SdMyAmTLom+6kfCuwIvAbgFSdTPsTFyf2A7IVKaaCknOSH21zADnt9oc6FxYbDUsJUlSF00PLNUk3K5af422zyCDCw18GctKMxM9gAUQYDUjdTrapqIfrbgi9x10SVoMjvyoNOxl6DlEJx9wdJmleJVatIN1q1iwipKZfJh23L6DKgF7WARnUw0TuZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=38dQtDKrsCUzk4mZVkf2drMOrhwH/LU2xnSYRAGDjss=;
 b=IxfVNekHjrwvg7+ZgufrSnvvLdwAJ7nABGFk3QlI5qrKjqUiMAch5kOUWLQKVPX0RV15CbxmYuQosYVIUEMZvdQYUzdInKoVUSB/MbJbHI1SPCJGI7Pv82ICa2lP30ADxqGfeQzKCgDKAHHfK5gG5AyooGRsTBIwTvhH194GJpF2f7fkgKuqi7DtItvb/5XB2wQ+5aysvdq6k09JHsJXBn58WRfKfbOWQK2i3d8KVfVF6hJBA+UvPHmpXLuLloHBO0nO62EeH7qM1ZHjUY1/FCRFQEXdMxpw6VCHwzFnVBVpK/pbspGu5GyjRj1FX//jPhiqYmEjNedmJVxmDnoX/w==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by PAXPR04MB8974.eurprd04.prod.outlook.com (2603:10a6:102:20d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.23; Thu, 8 Oct
 2026 13:45:03 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%6]) with mapi id 15.21.0496.010; Thu, 8 Oct 2026
 13:45:03 +0000
Date: Thu, 8 Oct 2026 21:49:35 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Will Deacon <will@kernel.org>, "Joerg Roedel (AMD)" <joro@8bytes.org>,
	Jean-Philippe Brucker <jpb@kernel.org>,
	Nicolin Chen <nicolinc@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	Thierry Reding <thierry.reding@kernel.org>,
	Krishna Reddy <vdumpa@nvidia.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
	Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH RFC v5 3/6] iommu/arm-smmu-v3: Delay stream allocation to
 inside the mutex
Message-ID: <asefb6KCCYCpShTX@shlinux89>
References: <20261006-smmu-shared-sid-v5-0-169a59c671d3@nxp.com>
 <20261006-smmu-shared-sid-v5-3-169a59c671d3@nxp.com>
 <d0e80505-b36f-40a9-a45f-957fff428c2a@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d0e80505-b36f-40a9-a45f-957fff428c2a@arm.com>
X-ClientProxiedBy: SI2PR01CA0046.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::18) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|PAXPR04MB8974:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e4ac801-337f-417a-60fb-08df25425af0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|19092799006|1800799024|23010399003|366016|22082099003|10067099003|18002099003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	3ICSTBbRDmxi8jgmte6h32zO9C3IFCIZFKb6VwsdYTsYD5DPP/1giwlH82yriyD1TLp+l9p+MCvag1I0vx1j1osoO+oQ+JMxW8PvQ/Bjbfx10DYzu4gskaJE3jNlSTSBN6xQfWHjYz8F3a8SZeIqILDLUXLCesF/IhMIXLCp/Q8QHfnS1tzZyResuGdwP4nd8TlRH9hCff7EM1mwbpeOgPMAFrMZo9HWOpSmRAgC11FtKyUucvTB5AiZkfY7YfjJa2AHrhm7P6vFOIm1zZ9KV5EkPzBojXFWwo/2WHkq/XhY9eqUTBXndb7o9OCTEfzl+kAJe2bTHl8CNyQeMNqhc7m0fGmykIEiN0cp9RIqCgBR9w+onVERht1ePFbHQ8wBM1XkBNa/MchkFM9eca8NhNKb1KoVxOjMwIEgONe5X8kjtz12o33LJh3TXoQDP29TSCfhbFSUk+Sgw9G38S1npUF9l/hYzZ+ct0xzJ/O86ovkOD7W7P0ENXrMgw7y8htZCta2yvCiVzo6QRXSzZKYF7uyccDotN5Qv+KonhLfySVEWeQ8hyHFYHhGD8XwTjEv4omuHVSVQZyVNJEF1R6d3oWXP/HIZdwY0soDXdNqL2GaAH4ATVoaFMJa+nzZPsHElcZnGSSMW9mn7bJaQpvPrNkAsbgHKU552Qgb/NL9+9Y=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7874.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(19092799006)(1800799024)(23010399003)(366016)(22082099003)(10067099003)(18002099003)(11063799006)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QcVGf4U4jFYbM4Mrv0yvjlE9EYms0OnBGpakFbWoakUB5BfOH3gsvxKp3t7o?=
 =?us-ascii?Q?r4cbuLPQ2o8PBmNx+Pr9xZS6ET0ViSOLZVFO71rYZSTc5XdVwAt5x94R0X2u?=
 =?us-ascii?Q?NUgvL7gM16o/Un9o4Jlvm+avjR4NLLH1ymcPij/JL4vx6ksTBCIzTgJ3xa+M?=
 =?us-ascii?Q?HCWoOHTMQcgPiTtm4Ly8Aj97rSbD+42/73s+Me3522gCWxvMap5s7BMnt7yR?=
 =?us-ascii?Q?0W2jKFo23kb59pzbMI7nDjpb5OOtAdKW6KftPl1fWLrFKVQoA7AA2kXriRaF?=
 =?us-ascii?Q?GJr3OrvwS5+JHN9SSHs0dPWEIBetTnSl/i4HLqgs3bTD72jXroW4WjwvNqc3?=
 =?us-ascii?Q?tGH9rruPFoKXXVXxAFlSjk+uXrTJXycf4mkrPxnGmdSzqnWbYMmeYdMdWMUA?=
 =?us-ascii?Q?hyMw+zzv7lOvTwAfAg2GjSzqDgS6UFCNF2Znu37lfSpAZpk+pj4C9Vxvuf8v?=
 =?us-ascii?Q?zWsKaySAwY63aRGUgO8i0UWwt6n4D7jupbeVk44byVKBb5giKyRnMm/1vCWO?=
 =?us-ascii?Q?sg8tqUrgta7qUR5AA4aiUR1PRYsewSEJhx/NZBx7qW5FnE5o2ca11yuoZefI?=
 =?us-ascii?Q?hTjnsat2yYbCqgHNHdBNw20sSC7LIZHNbvwJQFy0Ext4YJduvVY93kdHVfkk?=
 =?us-ascii?Q?vIxu3smgRbGsNOi6Kc1eAVskUDmA2pbnfV1/zxEwGdik9YliF8a54EWwHkfM?=
 =?us-ascii?Q?OnF+m7bu6KkU1eMA3jLgLZhz96ODR3M7yQNEQu9qMz+syUCq3jlTWcmPSavS?=
 =?us-ascii?Q?sQ8mY+zoer37zdRVSK7qZclo6c4q7Nr8PeOjROMPLcX3Sy4QuMaqniBOmJeJ?=
 =?us-ascii?Q?22K84wmRgIL382mFBIJVNXmYKFtxf/NcSAV8hr47owqJL02GRW3Gj4sdc42B?=
 =?us-ascii?Q?s+S14Ig2NPOESTUYE+R+4BRoKqMWvml4MF8aydoEzuswKRynjag6u6sbBFBL?=
 =?us-ascii?Q?7cgAoxzXo6/H6o5N+DGdOXsmCCbcE4Sd8kMAjg3xo7DPsc0fhGoftSV1XjgP?=
 =?us-ascii?Q?4flHhAb7CAZQ+ZrOYuI2p4QlUw4oAwapkvGVqu3ZbcbKUbEOD77WaD/4+riJ?=
 =?us-ascii?Q?3HYCrGKZsofgUASe5X7Eji7y1lT+3Lizk0H6mGCFuTnUMjPTA295WnzkNDVn?=
 =?us-ascii?Q?TC5UFN44tEwWyRUMSMFp3jC9xyewnZRZanc+Wd5xZEmEgHWA0ZEi+ewaUMF+?=
 =?us-ascii?Q?W/V14RScHZXaB8soFuv9Kt1E0a4BA0UTQ9YsvRB17Etk8uxNKrrkXJCNQRlL?=
 =?us-ascii?Q?3uiNUUQlA8ETGwtKmE3MykaKUVPZeEsczZaGBMjfBiGbF8hxDz11s98YLfJn?=
 =?us-ascii?Q?pbmqYTlFD+KR/RkJT+ps/+S3/a1RQEfpU8bZuXynDSz+29cabY+voliH7jAB?=
 =?us-ascii?Q?cJXtRltpdqIZHqgtu53X0ayBO8ae+E4CwQtRLrlefaq8IcvydJw2TjMhAWvf?=
 =?us-ascii?Q?Y8H+YnBTuge9X0YZLiurMdaWr4t+LjbF2HNcSQabhfoVN19KxZJ5LGb7J4E8?=
 =?us-ascii?Q?JAPvNb0ihv7NJCDx2zuJoUo/jnQDHH67O5IInqZo31ErKYKcDLerSp7DQ+Ip?=
 =?us-ascii?Q?Vi1legehNTEDZ1A+zQHVYWsPRv6XeiCUPF/2wcDsxKNzJIhY0UEAjJKOxbqA?=
 =?us-ascii?Q?KS8mwxqsg2y8cJldGoyq8cETAFHA8n6fjJLZhaM/o9B/KVmVchAoAZOErbAL?=
 =?us-ascii?Q?3tsMaSmDnopAgtUYKwjuLuwwlNEY9/+D708UlP5zObR4JwRXgTPmuv/2toMo?=
 =?us-ascii?Q?eVEvmpmyrzgqyIZQP84zODE25RfTkGVLOxb7ND5IWXSGvqIxGcOv?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e4ac801-337f-417a-60fb-08df25425af0
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2026 13:45:03.5109
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7Q9YcVZPzcW8/tE/wERr3PCkUjI2aDL0+gD0ibWezs4gbffU22pALXdM1OPvcG1C3UxWt+zBTXpih6RFV5WoJh0K/QasvvQTPVUiDZfEO8ozAerosm6HzdZU9xouoqjw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8974

On Thu, Oct 08, 2026 at 01:55:36PM +0100, Robin Murphy wrote:
>On 06/10/2026 1:19 pm, Peng Fan (OSS) wrote:
>> From: Peng Fan <peng.fan@nxp.com>
>> 
>> Move arm_smmu_stream allocation from upfront (before the mutex) into
>> the mutex-protected loop in arm_smmu_insert_master(). Instead of
>> pre-allocating all stream objects and then inserting them into the RB
>> tree, first look up whether the SID already exists in the tree. Only
>> allocate and insert a new stream when no existing entry is found, then
>> avoid unnecessary allocations when bridged PCI devices produce duplicated
>> IDs. Prepare the code for a subsequent patch that will reuse existing
>> streams when stream IDs are shared across masters.
>> 
>> The sort is also moved after the mutex section, since streams are now
>> populated inside the loop rather than beforehand.
>> 
>> Assisted-by: LLM
>> Signed-off-by: Peng Fan <peng.fan@nxp.com>
>> ---
>>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 102 +++++++++++++++-------------
>>   1 file changed, 53 insertions(+), 49 deletions(-)
>> 
>> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>> index 9d34eac196a65..69c2c3596b06a 100644
>> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>> @@ -4110,52 +4110,29 @@ static int arm_smmu_insert_master(struct arm_smmu_device *smmu,
>>   		return -ENOMEM;
>>   	}
>> -	for (i = 0; i < fwspec->num_ids; i++) {
>> -		struct arm_smmu_stream *new_stream;
>> -
>> -		new_stream = kzalloc_obj(*new_stream, GFP_KERNEL);
>> -		if (!new_stream) {
>> -			ret = -ENOMEM;
>> -			goto out_free_streams;
>> -		}
>> -		new_stream->id = fwspec->ids[i];
>> -		new_stream->master = master;
>> -		master->streams[i] = new_stream;
>> -	}
>> -
>> -	/* Put the ids into order for sorted to_merge/to_unref arrays */
>> -	sort(master->streams, master->num_streams,
>> -	     sizeof(master->streams[0]), arm_smmu_stream_id_cmp,
>> -	     NULL);
>> -
>> -	/*
>> -	 * Clear after sorting: RB_CLEAR_NODE() records the node's own address,
>> -	 * which sort_nonatomic() invalidates by relocating the entries.
>> -	 */
>> -	for (i = 0; i < fwspec->num_ids; i++)
>> -		RB_CLEAR_NODE(&master->streams[i]->node);
>> -
>>   	mutex_lock(&smmu->streams_mutex);
>>   	for (i = 0; i < fwspec->num_ids; i++) {
>> -		struct arm_smmu_stream *new_stream = master->streams[i];
>> +		struct arm_smmu_stream *stream;
>>   		struct rb_node *existing;
>> -		u32 sid = new_stream->id;
>> +		u32 sid = fwspec->ids[i];
>>   		ret = arm_smmu_init_sid_strtab(smmu, sid);
>>   		if (ret)
>>   			break;
>> -		/* Insert into SID tree */
>> -		existing = rb_find_add(&new_stream->node, &smmu->streams,
>> -				       arm_smmu_streams_cmp_node);
>> +		existing = rb_find(&sid, &smmu->streams,
>> +				   arm_smmu_streams_cmp_key);
>>   		if (existing) {
>>   			struct arm_smmu_master *existing_master =
>>   				rb_entry(existing, struct arm_smmu_stream, node)
>>   					->master;
>>   			/* Bridged PCI devices may end up with duplicated IDs */
>> -			if (existing_master == master)
>> +			if (existing_master == master) {
>> +				master->streams[i] = rb_entry(existing,
>> +					struct arm_smmu_stream, node);
>
>If we're now making the whole stream allocation and tracking business more
>dynamic anyway, could we not just skip inserting duplicate entries entirely,
>and save all the hassle elsewhere?

With duplication, the streams may looks as below:
streams[0] = ptr_to_stream(sid=0x10)
streams[1] = ptr_to_stream(sid=0x10)
streams[2] = ptr_to_stream(sid=0x20)
num_streams = 3

Withou duplicaition:
streams[0] = ptr_to_stream(sid=0x10)
streams[1] = ptr_to_stream(sid=0x20)
num_streams = 2

In next version:
I'll skip duplicate SIDs during insertion and track only unique
entries in master->streams[], with num_streams reflecting the
deduplicated count.

>
>IIRC, the only real reason for not actively deduplicating originally in
>563b5cbe334e ("iommu/arm-smmu-v3: Cope with duplicated Stream IDs") was to
>keep it to the simplest fix that was easier to backport, and at the time it
>was easy to get away with since it only mattered at that one particular
>point. If we have to start copying the double-loop bodge around to multiple
>places, it rather stops looking like the neatest option...

Right, with the old embedded array the duplicate entries were
essentially free (just unused slots with the same SID), so the
"skip and continue" bodge was a reasonable minimal fix. But now
that we individually allocate streams and store shared pointers,
keeping duplicates means dedup logic in every cleanup path.
Agreed it's better to just not insert them in the first place.

As above, I will not keep duplicated SIDs in V6.

Thanks
Peng

>
>Thanks,
>Robin.
>
>>   				continue;
>> +			}
>>   			dev_warn(master->dev,
>>   				 "Aliasing StreamID 0x%x (from %s) unsupported, expect DMA to be broken\n",
>> @@ -4163,45 +4140,72 @@ static int arm_smmu_insert_master(struct arm_smmu_device *smmu,
>>   			ret = -ENODEV;
>>   			break;
>>   		}
>> +
>> +		stream = kzalloc_obj(*stream, GFP_KERNEL);
>> +		if (!stream) {
>> +			ret = -ENOMEM;
>> +			break;
>> +		}
>> +		stream->id = sid;
>> +		stream->master = master;
>> +
>> +		rb_find_add(&stream->node, &smmu->streams,
>> +			    arm_smmu_streams_cmp_node);
>> +		master->streams[i] = stream;
>>   	}
>>   	if (ret) {
>> -		for (i--; i >= 0; i--)
>> -			if (!RB_EMPTY_NODE(&master->streams[i]->node))
>> -				rb_erase(&master->streams[i]->node,
>> -					 &smmu->streams);
>> +		for (i--; i >= 0; i--) {
>> +			int j;
>> +
>> +			if (!master->streams[i])
>> +				continue;
>> +			/* Skip duplicated SID pointers already freed */
>> +			for (j = 0; j < i; j++)
>> +				if (master->streams[j] == master->streams[i])
>> +					break;
>> +			if (j < i)
>> +				continue;
>> +			rb_erase(&master->streams[i]->node, &smmu->streams);
>> +			kfree(master->streams[i]);
>> +		}
>>   		mutex_unlock(&smmu->streams_mutex);
>> -		goto out_free_streams;
>> +		kfree(master->streams);
>> +		kfree(master->build_invs);
>> +		return ret;
>>   	}
>>   	mutex_unlock(&smmu->streams_mutex);
>> -	return 0;
>> +	/* Put the ids into order for sorted to_merge/to_unref arrays */
>> +	sort(master->streams, master->num_streams,
>> +	     sizeof(master->streams[0]), arm_smmu_stream_id_cmp,
>> +	     NULL);
>> -out_free_streams:
>> -	for (i = 0; i < master->num_streams; i++)
>> -		kfree(master->streams[i]);
>> -	kfree(master->streams);
>> -	kfree(master->build_invs);
>> -	return ret;
>> +	return 0;
>>   }
>>   static void arm_smmu_remove_master(struct arm_smmu_master *master)
>>   {
>>   	int i;
>>   	struct arm_smmu_device *smmu = master->smmu;
>> -	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(master->dev);
>>   	if (!smmu || !master->streams)
>>   		return;
>>   	mutex_lock(&smmu->streams_mutex);
>> -	for (i = 0; i < fwspec->num_ids; i++)
>> -		if (!RB_EMPTY_NODE(&master->streams[i]->node))
>> -			rb_erase(&master->streams[i]->node, &smmu->streams);
>> -	mutex_unlock(&smmu->streams_mutex);
>> +	for (i = 0; i < master->num_streams; i++) {
>> +		int j;
>> -	for (i = 0; i < master->num_streams; i++)
>> +		/* Skip duplicated SID pointers already freed */
>> +		for (j = 0; j < i; j++)
>> +			if (master->streams[j] == master->streams[i])
>> +				break;
>> +		if (j < i)
>> +			continue;
>> +		rb_erase(&master->streams[i]->node, &smmu->streams);
>>   		kfree(master->streams[i]);
>> +	}
>> +	mutex_unlock(&smmu->streams_mutex);
>>   	kfree(master->streams);
>>   	kfree(master->build_invs);
>> 
>
>
