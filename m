Return-Path: <SRS0=YF8t=OU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0860AC433F5
	for <iommu@archiver.kernel.org>; Thu, 30 Sep 2021 09:24:40 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A37EB61882
	for <iommu@archiver.kernel.org>; Thu, 30 Sep 2021 09:24:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A37EB61882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 68FCB40200;
	Thu, 30 Sep 2021 09:24:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6dnu1j-fEsPa; Thu, 30 Sep 2021 09:24:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 70E46400DD;
	Thu, 30 Sep 2021 09:24:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 361E6C000F;
	Thu, 30 Sep 2021 09:24:37 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 045BAC000D;
 Thu, 30 Sep 2021 09:24:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E7F5E42533;
 Thu, 30 Sep 2021 09:24:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com
 header.b="UgRV64i+"; dkim=pass (1024-bit key)
 header.d=armh.onmicrosoft.com header.b="UgRV64i+"
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Y5iWORmJh9dX; Thu, 30 Sep 2021 09:24:35 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-eopbgr80051.outbound.protection.outlook.com [40.107.8.51])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B50294234E;
 Thu, 30 Sep 2021 09:24:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com; 
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EU1md94yulkTb6YSXf2rBeH9qpKroKXOd2u4ABb8uXo=;
 b=UgRV64i+5cLqLV+i6BIwY8JXPw5AvFxmu1xpckllDJeRMmrA/QdZCaEp19SW4pwKUhjMJJNW6A6wNxmM7yTndCv9civEmD+oX0o1ih0WDu3eVPKX6cMcq0AWU41I8j7Vv9g78kvR3rdlLvJJtuomR9kZJcXhmIbULJwRGkudHUM=
Received: from AS9PR06CA0068.eurprd06.prod.outlook.com (2603:10a6:20b:464::32)
 by DBAPR08MB5701.eurprd08.prod.outlook.com (2603:10a6:10:1a6::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.16; Thu, 30 Sep
 2021 09:24:27 +0000
Received: from AM5EUR03FT038.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:20b:464:cafe::f4) by AS9PR06CA0068.outlook.office365.com
 (2603:10a6:20b:464::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14 via Frontend
 Transport; Thu, 30 Sep 2021 09:24:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; lists.linux-foundation.org; dkim=pass (signature was
 verified) header.d=armh.onmicrosoft.com;lists.linux-foundation.org;
 dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT038.mail.protection.outlook.com (10.152.17.118) with
 Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4566.14 via Frontend Transport; Thu, 30 Sep 2021 09:24:25 +0000
Received: ("Tessian outbound 71ebfb754289:v103");
 Thu, 30 Sep 2021 09:24:25 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 09b808f6f90c323a
X-CR-MTA-TID: 64aa7808
Received: from 788162a92486.3
 by 64aa7808-outbound-1.mta.getcheckrecipient.com id
 95CF8B87-FB00-486E-A417-31FD87DED041.1; 
 Thu, 30 Sep 2021 09:24:14 +0000
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 788162a92486.3
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
 Thu, 30 Sep 2021 09:24:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KBlZzpBwYm3AbA2ZH1FA5bXiFTVQVEIcH3cAHPYYIlZi/TUTiKzZWdDTu/XX+MDZR3ruEgqB2sZ1N6fv6XhZoY28RZaV7NqucJlfYWaE1NI+BqGGZwEMvyZPgNP+OkCBjUbsNzPVB6k3Cym5a3cbZeJ8pYSqBnVzh7iDqEocVKcek7cYw9/XlKH1DHI8PSavz04msB/sRb+KETewdIS8LfotdpFPUGHxQseXouVOc+Iq64tnVGZBIhSan277s0q3og+6e/rJKfzEXX71gcJ9MLBvVdtFKTQfWCY5yhj/L4Py/jkbtm2Pbt07eHz4jZgI8zeVRQjpDJFWJEbYIJ5ulQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=EU1md94yulkTb6YSXf2rBeH9qpKroKXOd2u4ABb8uXo=;
 b=Em6cG1MGhoxpd+CMqSeKPjxf5Bz7j+UNvmtWqt6/Kx5VwYGn+m2ovvwqDtJVPdr0PqdJ/OUpmIwbP4nbFW0QunpjugYwJzLLai9S83QJIwWcuzXSpiVihcvmu+uJTsFzmjthpKZBreggsh+1rCh9xO6PbniaJnFXAPIb3AjwwLxIIpVMXvCUkJ8twCLbOt8C0LcXKa818zFD5jsvwTh4eLJx0pClAyeTvRLsHd6rsU8b2ZNmhzaYZf6+go3RsOYkQCbsGbGId1M1ngthSyWqUJQBlOfEefRy49izL/3gzInvcxrpdv9qquzpLYoI2LXHP50Z4mj9Xz/zQ02UIrB5/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com; 
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EU1md94yulkTb6YSXf2rBeH9qpKroKXOd2u4ABb8uXo=;
 b=UgRV64i+5cLqLV+i6BIwY8JXPw5AvFxmu1xpckllDJeRMmrA/QdZCaEp19SW4pwKUhjMJJNW6A6wNxmM7yTndCv9civEmD+oX0o1ih0WDu3eVPKX6cMcq0AWU41I8j7Vv9g78kvR3rdlLvJJtuomR9kZJcXhmIbULJwRGkudHUM=
Authentication-Results-Original: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=arm.com;
Received: from DB6PR08MB2645.eurprd08.prod.outlook.com (2603:10a6:6:24::25) by
 DB6PR0801MB1960.eurprd08.prod.outlook.com (2603:10a6:4:76::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4544.13; Thu, 30 Sep 2021 09:24:12 +0000
Received: from DB6PR08MB2645.eurprd08.prod.outlook.com
 ([fe80::2cb2:fad6:c5f7:4501]) by DB6PR08MB2645.eurprd08.prod.outlook.com
 ([fe80::2cb2:fad6:c5f7:4501%6]) with mapi id 15.20.4544.021; Thu, 30 Sep 2021
 09:24:12 +0000
Subject: Re: [PATCH RFC v1 10/11] uapi/virtio-iommu: Add a new request type to
 send page response
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
References: <20210423095147.27922-1-vivek.gautam@arm.com>
 <20210423095147.27922-11-vivek.gautam@arm.com> <YUoFSrAK2gi3GWp/@myrica>
From: Vivek Kumar Gautam <vivek.gautam@arm.com>
Message-ID: <d40ea85b-3612-10b3-0add-40d07e6d9ca5@arm.com>
Date: Thu, 30 Sep 2021 14:54:05 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <YUoFSrAK2gi3GWp/@myrica>
Content-Language: en-US
X-ClientProxiedBy: BM1PR01CA0143.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:68::13) To DB6PR08MB2645.eurprd08.prod.outlook.com
 (2603:10a6:6:24::25)
MIME-Version: 1.0
Received: from [10.162.16.71] (217.140.105.56) by
 BM1PR01CA0143.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:68::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4566.13 via Frontend Transport; Thu, 30 Sep 2021 09:24:09 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ed177043-2e2c-46ab-7534-08d983f418a9
X-MS-TrafficTypeDiagnostic: DB6PR0801MB1960:|DBAPR08MB5701:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DBAPR08MB570105E15E668AFF0C8D27E589AA9@DBAPR08MB5701.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: X5KDNntZ5iY2DpB+Y19vnCTJ8BKGwPq/8mWOhNKERLaCR2971NFfrQL6HKfppOlH7xQr9he5pj7foyiolmSc/dLK0iCFwWi4M1UrQrHAhdLIMevpbwmo+LP1YUFDeTGoAZq3rXiuTHMx2qjVYJ6EOhMHFmLjLDojqgllUhIb/Qdedb5mdDUriKjOEH5qpxJzEOauF0JyCJDhX/Em8vU7HsEwXjm1yvfFMJzvCHzoGw5emJ7Y0CgwJMXjy6awqmTbY4Cz9HWED+DE/uOeAEDNiTuHemR6ie43x2WnhOibnpyvkZLd+lWszIJenQefniEYeKoV+0uw74ePTgL5zQbqRyUm1oTbNvuVpLTML4YYMtC/VGTIDCEEAfujkNNRJo1V+DPufFPAxt0+hRCfbWv0LColYYXwNojEWwcmgUe2KtgvjTd1l4DSvADsprbLuIsJBCtnRhpcBf0mpkXpu8trPTHiJVNEnNveTdz7xMB/1Pv/4AzwchKd+GVPW/F3SU4G34atm85ONKL5p1mFldBc8+V6ONdY8W5gn1TDPmRguTdbppHIFiGlkel2dbrDYaeZrXvuUGqfWh8htwBbowlasa0O9pmX6UpOofuMGIeLMgsnoqaAxVFeabtFT+ZxjDXmPMU3ri8/Vy+37Hz1aI83zwvwaa2LvDkm/fcK/c7Gak+OqaQhbzjodr7hjhAVroNVh5jdY6is6hxq8HzplkLmasfFyDxN42buwiBDz7Eb368KG7h/72x2GH4oWpLjLlhnWreMq18VQSBS81R17POudg==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:DB6PR08MB2645.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(4636009)(366004)(7416002)(4326008)(38350700002)(8936002)(36756003)(16576012)(316002)(31696002)(508600001)(6486002)(83380400001)(8676002)(86362001)(38100700002)(52116002)(2906002)(5660300002)(31686004)(66946007)(956004)(66476007)(66556008)(6666004)(6916009)(26005)(186003)(53546011)(2616005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0801MB1960
Original-Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT038.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: fa945b30-56d6-4120-007f-08d983f4104b
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NZO/HXwgmCp7YFOkE6vTH02KIV7sFBlxBBdF0+0eYI0Faxp+X3bXUweA+1TOgdu399OmO6KwvxQ0SVkwmW923VihHs/VjacufBbk28EuxtSBjf7vb2wDNjuEyW/X7qxOry6XqKDWBBYph4Pfdfv0oxv+hnIFFlD5nM99f3GjsScuGClgBKihpuxrclxrUspykNJ60y+DpDz8eIkFkRALE2LfOhhd5O8LlVTsZvc/fWvYUZjyneJSnTcPIMO4Evp2t/Cwc4ptvipAcXyD7Jb+7ky93F1C8eeCux4CI7/8TG4IL9F2zkT/6rnpGm23Go3KCLxqTwCldYkUG5fgd+n5RlrCyxyiJuBOiLcokZnp9BpnzKqTNg+KcH+fW7AYgkFIEftR/j215XRhR0wqn69oKm8VcJ5IWRYRaihHRWVDAkQgKfe57NkNIU0VIVexB4BDkvhRruFWwOtPYbOJTcrRsMiwILjQJZ9HEKWeLxIfkL7qrOnPC8rYn+9MWbw8uiL+XAmUHSZNwZBV8z6E6yXWWD273ypmkm6eXQuxd/vWy4VNqxb7cco8YijfeLH00t9m/dIpiUpitHBDet0PLSpVZ2iE39Ln8qHgxSDdm22sqo25by2znOYs/8DGOxQIINjmPsPZuKfltH6UTzvEZOjpwImT+0FaZx3ghhaak5g/SuAVOi8tPZJdAc+t+roBu5pidta+fYPTFo1Q0KuERwWeptf8MP9EwhVyKtNvj/lP6P4=
X-Forefront-Antispam-Report: CIP:63.35.35.123; CTRY:IE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:64aa7808-outbound-1.mta.getcheckrecipient.com;
 PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(53546011)(450100002)(47076005)(82310400003)(70206006)(6862004)(83380400001)(70586007)(4326008)(107886003)(6666004)(5660300002)(86362001)(956004)(2906002)(356005)(186003)(31686004)(508600001)(316002)(8936002)(16576012)(31696002)(36756003)(6486002)(36860700001)(81166007)(336012)(26005)(8676002)(2616005)(43740500002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2021 09:24:25.7813 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed177043-2e2c-46ab-7534-08d983f418a9
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[63.35.35.123];
 Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: AM5EUR03FT038.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR08MB5701
Cc: kevin.tian@intel.com, mst@redhat.com, will.deacon@arm.com,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 iommu@lists.linux-foundation.org, robin.murphy@arm.com,
 linux-arm-kernel@lists.infradead.org
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

Hi Jean,


On 9/21/21 9:46 PM, Jean-Philippe Brucker wrote:
> On Fri, Apr 23, 2021 at 03:21:46PM +0530, Vivek Gautam wrote:
>> Once the page faults are handled, the response has to be sent to
>> virtio-iommu backend, from where it can be sent to the host to
>> prepare the response to a generated io page fault by the device.
>> Add a new virt-queue request type to handle this.
>>
>> Signed-off-by: Vivek Gautam <vivek.gautam@arm.com>
>> ---
>>   include/uapi/linux/virtio_iommu.h | 18 ++++++++++++++++++
>>   1 file changed, 18 insertions(+)
>>
>> diff --git a/include/uapi/linux/virtio_iommu.h b/include/uapi/linux/virtio_iommu.h
>> index c12d9b6a7243..1b174b98663a 100644
>> --- a/include/uapi/linux/virtio_iommu.h
>> +++ b/include/uapi/linux/virtio_iommu.h
>> @@ -48,6 +48,7 @@ struct virtio_iommu_config {
>>   #define VIRTIO_IOMMU_T_PROBE			0x05
>>   #define VIRTIO_IOMMU_T_ATTACH_TABLE		0x06
>>   #define VIRTIO_IOMMU_T_INVALIDATE		0x07
>> +#define VIRTIO_IOMMU_T_PAGE_RESP		0x08
>>   
>>   /* Status types */
>>   #define VIRTIO_IOMMU_S_OK			0x00
>> @@ -70,6 +71,23 @@ struct virtio_iommu_req_tail {
>>   	__u8					reserved[3];
>>   };
>>   
>> +struct virtio_iommu_req_page_resp {
>> +	struct virtio_iommu_req_head		head;
>> +	__le32					domain;
> 
> I don't think we need this field, since the fault report doesn't come with
> a domain.

But here we are sending the response which would be consumed by the vfio 
ultimately. In kvmtool, I am consuming this "virtio_iommu_req_page_resp" 
request in the virtio/iommu driver, extracting the domain from it, and 
using that to call the respective "page_response" ops from 
"vfio_iommu_ops" in the vfio/core driver.

Is this incorrect way of passing on the page-response back to the host 
kernel?

But I think this will have to be worked out with the /dev/iommu framework.

> 
>> +	__le32					endpoint;
>> +#define VIRTIO_IOMMU_PAGE_RESP_PASID_VALID	(1 << 0)
> 
> To be consistent with the rest of the document this would be
> VIRTIO_IOMMU_PAGE_RESP_F_PASID_VALID

Sure, will update this.

> 
>> +	__le32					flags;
>> +	__le32					pasid;
>> +	__le32					grpid;
>> +#define VIRTIO_IOMMU_PAGE_RESP_SUCCESS		(0x0)
>> +#define VIRTIO_IOMMU_PAGE_RESP_INVALID		(0x1)
>> +#define VIRTIO_IOMMU_PAGE_RESP_FAILURE		(0x2)
>> +	__le16					resp_code;
>> +	__u8					pasid_valid;
> 
> This field isn't needed since there already is
> VIRTIO_IOMMU_PAGE_RESP_PASID_VALID

Yes, sure will remove this field.

> 
>> +	__u8					reserved[9];
>> +	struct virtio_iommu_req_tail		tail;
>> +};
> 
> I'd align the size of the struct to 16 bytes, but I don't think that's
> strictly necessary.

Will fix this. Thanks a lot for reviewing.

Best regards
Vivek

> 
> Thanks,
> Jean
> 
>> +
>>   struct virtio_iommu_req_attach {
>>   	struct virtio_iommu_req_head		head;
>>   	__le32					domain;
>> -- 
>> 2.17.1
>>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
