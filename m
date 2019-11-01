Return-Path: <SRS0=gESx=YZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5E13C47E49
	for <iommu@archiver.kernel.org>; Fri,  1 Nov 2019 10:28:05 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94A08217D9
	for <iommu@archiver.kernel.org>; Fri,  1 Nov 2019 10:28:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94A08217D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 44F1B661A;
	Fri,  1 Nov 2019 10:28:05 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 34B25660E
	for <iommu@lists.linux-foundation.org>;
	Fri,  1 Nov 2019 10:28:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from huawei.com (lhrrgout.huawei.com [185.176.76.210])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id BDCC963D
	for <iommu@lists.linux-foundation.org>;
	Fri,  1 Nov 2019 10:28:02 +0000 (UTC)
Received: from lhreml702-cah.china.huawei.com (unknown [172.18.7.107])
	by Forcepoint Email with ESMTP id 70EE85BF96E37D5CA1A8;
	Fri,  1 Nov 2019 10:28:00 +0000 (GMT)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
	lhreml702-cah.china.huawei.com (10.201.108.43) with Microsoft SMTP
	Server (TLS) id 14.3.408.0; Fri, 1 Nov 2019 10:28:00 +0000
Received: from [127.0.0.1] (10.202.226.45) by lhreml724-chm.china.huawei.com
	(10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
	cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5;
	Fri, 1 Nov 2019 10:27:59 +0000
Subject: Re: [PATCH 0/7] iommu: Permit modular builds of ARM SMMU[v3] drivers
To: Saravana Kannan <saravanak@google.com>, Jean-Philippe Brucker
	<jean-philippe@linaro.org>
References: <20191030145112.19738-1-will@kernel.org>
	<6e457227-ca06-2998-4ffa-a58ab171ce32@arm.com>
	<20191030155444.GC19096@willie-the-truck>
	<CAGETcx9ogWQC1ZtnS_4xC3ShqBpuRSKudWEEWC22UZUEhdEU4A@mail.gmail.com>
	<20191031193758.GA2607492@lophozonia>
	<CAGETcx-MuMVvj0O-MFdfmLADEq=cQY_=x+irvhgwHhG4VeeSdg@mail.gmail.com>
From: John Garry <john.garry@huawei.com>
Message-ID: <6994ae35-2b89-2feb-2bcb-cffc5a01963c@huawei.com>
Date: Fri, 1 Nov 2019 10:27:59 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
	Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <CAGETcx-MuMVvj0O-MFdfmLADEq=cQY_=x+irvhgwHhG4VeeSdg@mail.gmail.com>
Content-Language: en-US
X-Originating-IP: [10.202.226.45]
X-ClientProxiedBy: lhreml716-chm.china.huawei.com (10.201.108.67) To
	lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Cc: Bjorn Helgaas <bhelgaas@google.com>, Will Deacon <will@kernel.org>,
	"iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
	Robin Murphy <robin.murphy@arm.com>, LKML <linux-kernel@vger.kernel.org>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

On 31/10/2019 23:34, Saravana Kannan via iommu wrote:
> I looked into the iommu-map property and it shouldn't be too hard to
> add support for it. Looks like we can simply hold off on probing the
> root bridge device till all the iommus in its iommu-map are probed and
> we should be fine.
> 
>> I'm also unsure about distro vendors agreeing to a mandatory kernel
>> parameter (of_devlink). Do you plan to eventually enable it by default?
>>
>>> static const struct supplier_bindings of_supplier_bindings[] = {
>>>          { .parse_prop = parse_clocks, },
>>>          { .parse_prop = parse_interconnects, },
>>>          { .parse_prop = parse_regulators, },
>>> +        { .parse_prop = parse_iommus, },
>>>          {},
>>> };
>>>
>>> I plan to upstream this pretty soon, but I have other patches in
>>> flight that touch the same file and I'm waiting for those to get
>>> accepted. I also want to clean up the code a bit to reduce some
>>> repetition before I add support for more bindings.
>> I'm also wondering about ACPI support.
> I'd love to add ACPI support too, but I have zero knowledge of ACPI.
> I'd be happy to help anyone who wants to add ACPI support that allows
> ACPI to add device links.

If possible to add, that may be useful for remedying this:

https://lore.kernel.org/linux-iommu/9625faf4-48ef-2dd3-d82f-931d9cf26976@huawei.com/

Thanks,
John

> 
>> IOMMU already has a sort of
>> canonical code path that links endpoints to their IOMMU
>> (iommu_probe_device()), after the firmware descriptions have been parsed.
>> So if we created the device links in the iommu core, for example
>> iommu_bus_notifier(), we would support all firmware interface fl

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
