Return-Path: <SRS0=xf59=C2=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC520C43461
	for <iommu@archiver.kernel.org>; Thu, 17 Sep 2020 16:50:35 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F034206CA
	for <iommu@archiver.kernel.org>; Thu, 17 Sep 2020 16:50:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XYWjn6NF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F034206CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 2EC7B87152;
	Thu, 17 Sep 2020 16:50:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IRXIL3fFMfG0; Thu, 17 Sep 2020 16:50:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id D032D8718F;
	Thu, 17 Sep 2020 16:50:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B2BFAC0859;
	Thu, 17 Sep 2020 16:50:31 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 622F7C0051
 for <iommu@lists.linux-foundation.org>; Thu, 17 Sep 2020 16:50:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 5DBC48792B
 for <iommu@lists.linux-foundation.org>; Thu, 17 Sep 2020 16:50:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Q3g6rDZEdnvl for <iommu@lists.linux-foundation.org>;
 Thu, 17 Sep 2020 16:50:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from userp2120.oracle.com (userp2120.oracle.com [156.151.31.85])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 114078791F
 for <iommu@lists.linux-foundation.org>; Thu, 17 Sep 2020 16:50:28 +0000 (UTC)
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08HGYguH141258;
 Thu, 17 Sep 2020 16:50:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=AAT4TuYimvECaHtzgMKogsLErEMuk/dMmKD/ZXWqr80=;
 b=XYWjn6NFFhXL2UTXdKsijJvUx3br558LXskRZGNxvp9TQrOesHB6wGaNQGjN/IUTSlP2
 h+diJggNZ09Sjk+xfs5lf4fqt0G/JsH1q80TzksSavk6MUpnudQEVuvOfQWOI73J+hjr
 +pRF4nVU0P8LtPhRrA3ywXQf3SnVdpRTeO6VxtCJQIfKeZa15eM4RzgHx/UeZI4NwPwn
 DsAa9WrmVfPjDQkaQPUR2fkFqHNvgoKGxaN4z1yxvX52HzoHI0aHvOvQqTZSAUKwclnk
 7ID9G/1D+ElLJokCfrTfc8tRgDri0mfGct3cZP/CY7+/D+QPSSeMPsszfkdnkkYttJXu Yw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by userp2120.oracle.com with ESMTP id 33j91dv5ug-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 17 Sep 2020 16:50:26 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08HGa41o081563;
 Thu, 17 Sep 2020 16:48:25 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by aserp3030.oracle.com with ESMTP id 33khpnbcn4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 17 Sep 2020 16:48:25 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 08HGmORl025800;
 Thu, 17 Sep 2020 16:48:24 GMT
Received: from [10.39.232.73] (/10.39.232.73)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 17 Sep 2020 16:48:24 +0000
Subject: Re: [PATCH V2] dma-direct: Fix potential NULL pointer dereference
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
References: <1600289466-23805-1-git-send-email-thomas.tai@oracle.com>
 <20200917160517.GB10122@char.us.oracle.com>
From: Thomas Tai <thomas.tai@oracle.com>
Message-ID: <6b80964e-67fd-ba9b-8df4-114bfb45d684@oracle.com>
Date: Thu, 17 Sep 2020 12:48:22 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200917160517.GB10122@char.us.oracle.com>
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9747
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 suspectscore=0
 mlxlogscore=999 phishscore=0 mlxscore=0 adultscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009170126
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9747
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 impostorscore=0
 priorityscore=1501 malwarescore=0 suspectscore=0 mlxlogscore=999
 clxscore=1015 adultscore=0 lowpriorityscore=0 spamscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009170126
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 robin.murphy@arm.com, hch@lst.de
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>



On 2020-09-17 12:05 p.m., Konrad Rzeszutek Wilk wrote:
> On Wed, Sep 16, 2020 at 02:51:06PM -0600, Thomas Tai wrote:
>> When booting the kernel v5.9-rc4 on a VM, the kernel would panic when
>> printing a warning message in swiotlb_map(). The dev->dma_mask must not
>> be a NULL pointer when calling the dma mapping layer. A NULL pointer check
>> can potentially avoid the panic.
>>
>> [drm] Initialized virtio_gpu 0.1.0 0 for virtio0 on minor 0
>>   BUG: kernel NULL pointer dereference, address: 0000000000000000
>>   #PF: supervisor read access in kernel mode
>>   #PF: error_code(0x0000) - not-present page
>>   PGD 0 P4D 0
>>   Oops: 0000 [#1] SMP PTI
>>   CPU: 1 PID: 331 Comm: systemd-udevd Not tainted 5.9.0-rc4 #1
>>   Hardware name: QEMU Standard PC (Q35 + ICH9, 2009),
>>   BIOS 1.13.0-1ubuntu1 04/01/2014
>>   RIP: 0010:swiotlb_map+0x1ac/0x200
>>   Code: e8 d9 fc ff ff 80 3d 92 ee 4c 01 00 75 51 49 8b 84 24 48 02 00 00
>>   4d 8b 6c 24 50 c6 05 7c ee 4c 01 01 4d 8b bc 24 58 02 00 00 <4c> 8b 30
>>   4d 85 ed 75 04 4d 8b 2c 24 4c 89 e7 e8 10 6b 4f 00 4d 89
>>   RSP: 0018:ffff9f96801af6f8 EFLAGS: 00010246
>>   RAX: 0000000000000000 RBX: 0000000000001000 RCX: 0000000000000080
>>   RDX: 000000000000007f RSI: 0000000000000202 RDI: 0000000000000202
>>   RBP: ffff9f96801af748 R08: ffffffffffffffff R09: 0000000000000020
>>   R10: 0000000000000000 R11: ffff8fabfffa3000 R12: ffff8faad02c7810
>>   R13: 0000000000000000 R14: 0000000000000020 R15: 0000000000000000
>>   FS:  00007fabc63588c0(0000) GS:ffff8fabf7c80000(0000)
>>   knlGS:0000000000000000
>>   CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>   CR2: 0000000000000000 CR3: 0000000151496005 CR4: 0000000000370ee0
>>   DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>>   DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>>   Call Trace:
>>    dma_direct_map_sg+0x124/0x210
>>    dma_map_sg_attrs+0x32/0x50
>>    drm_gem_shmem_get_pages_sgt+0x6a/0x90 [drm]
>>    virtio_gpu_object_create+0x140/0x2f0 [virtio_gpu]
>>    ? ww_mutex_unlock+0x26/0x30
>>    virtio_gpu_mode_dumb_create+0xab/0x160 [virtio_gpu]
>>    drm_mode_create_dumb+0x82/0x90 [drm]
>>    drm_client_framebuffer_create+0xaa/0x200 [drm]
>>    drm_fb_helper_generic_probe+0x59/0x150 [drm_kms_helper]
>>    drm_fb_helper_single_fb_probe+0x29e/0x3e0 [drm_kms_helper]
>>    __drm_fb_helper_initial_config_and_unlock+0x41/0xd0 [drm_kms_helper]
>>    drm_fbdev_client_hotplug+0xe6/0x1a0 [drm_kms_helper]
>>    drm_fbdev_generic_setup+0xaf/0x170 [drm_kms_helper]
>>    virtio_gpu_probe+0xea/0x100 [virtio_gpu]
>>    virtio_dev_probe+0x14b/0x1e0 [virtio]
>>    really_probe+0x1db/0x440
>>    driver_probe_device+0xe9/0x160
>>    device_driver_attach+0x5d/0x70
>>    __driver_attach+0x8f/0x150
>>    ? device_driver_attach+0x70/0x70
>>    bus_for_each_dev+0x7e/0xc0
>>    driver_attach+0x1e/0x20
>>    bus_add_driver+0x152/0x1f0
>>    driver_register+0x74/0xd0
>>    ? 0xffffffffc0529000
>>    register_virtio_driver+0x20/0x30 [virtio]
>>    virtio_gpu_driver_init+0x15/0x1000 [virtio_gpu]
>>    do_one_initcall+0x4a/0x1fa
>>    ? _cond_resched+0x19/0x30
>>    ? kmem_cache_alloc_trace+0x16b/0x2e0
>>    do_init_module+0x62/0x240
>>    load_module+0xe0e/0x1100
>>    ? security_kernel_post_read_file+0x5c/0x70
>>    __do_sys_finit_module+0xbe/0x120
>>    ? __do_sys_finit_module+0xbe/0x120
>>    __x64_sys_finit_module+0x1a/0x20
>>    do_syscall_64+0x38/0x50
>>    entry_SYSCALL_64_after_hwframe+0x44/0xa9
>>
>> Signed-off-by: Thomas Tai <thomas.tai@oracle.com>
> 
> Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>

Thank you, Konrad for reviewing the fix.

Thomas

> 
> Thank you!
>> ---
>>   include/linux/dma-direct.h |  3 ---
>>   kernel/dma/mapping.c       | 11 +++++++++++
>>   2 files changed, 11 insertions(+), 3 deletions(-)
>>
>> diff --git a/include/linux/dma-direct.h b/include/linux/dma-direct.h
>> index 6e87225..0648708 100644
>> --- a/include/linux/dma-direct.h
>> +++ b/include/linux/dma-direct.h
>> @@ -62,9 +62,6 @@ static inline bool dma_capable(struct device *dev, dma_addr_t addr, size_t size,
>>   {
>>   	dma_addr_t end = addr + size - 1;
>>   
>> -	if (!dev->dma_mask)
>> -		return false;
>> -
>>   	if (is_ram && !IS_ENABLED(CONFIG_ARCH_DMA_ADDR_T_64BIT) &&
>>   	    min(addr, end) < phys_to_dma(dev, PFN_PHYS(min_low_pfn)))
>>   		return false;
>> diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
>> index 0d12942..7133d5c 100644
>> --- a/kernel/dma/mapping.c
>> +++ b/kernel/dma/mapping.c
>> @@ -144,6 +144,10 @@ dma_addr_t dma_map_page_attrs(struct device *dev, struct page *page,
>>   	dma_addr_t addr;
>>   
>>   	BUG_ON(!valid_dma_direction(dir));
>> +
>> +	if (WARN_ON_ONCE(!dev->dma_mask))
>> +		return DMA_MAPPING_ERROR;
>> +
>>   	if (dma_map_direct(dev, ops))
>>   		addr = dma_direct_map_page(dev, page, offset, size, dir, attrs);
>>   	else
>> @@ -179,6 +183,10 @@ int dma_map_sg_attrs(struct device *dev, struct scatterlist *sg, int nents,
>>   	int ents;
>>   
>>   	BUG_ON(!valid_dma_direction(dir));
>> +
>> +	if (WARN_ON_ONCE(!dev->dma_mask))
>> +		return 0;
>> +
>>   	if (dma_map_direct(dev, ops))
>>   		ents = dma_direct_map_sg(dev, sg, nents, dir, attrs);
>>   	else
>> @@ -213,6 +221,9 @@ dma_addr_t dma_map_resource(struct device *dev, phys_addr_t phys_addr,
>>   
>>   	BUG_ON(!valid_dma_direction(dir));
>>   
>> +	if (WARN_ON_ONCE(!dev->dma_mask))
>> +		return DMA_MAPPING_ERROR;
>> +
>>   	/* Don't allow RAM to be mapped */
>>   	if (WARN_ON_ONCE(pfn_valid(PHYS_PFN(phys_addr))))
>>   		return DMA_MAPPING_ERROR;
>> -- 
>> 1.8.3.1
>>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
