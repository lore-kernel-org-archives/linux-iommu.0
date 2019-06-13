Return-Path: <SRS0=dZmg=UM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32144C468B0
	for <iommu@archiver.kernel.org>; Thu, 13 Jun 2019 15:46:59 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F5E520851
	for <iommu@archiver.kernel.org>; Thu, 13 Jun 2019 15:46:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F5E520851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id E0B25E30;
	Thu, 13 Jun 2019 15:46:58 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 26F34E30
	for <iommu@lists.linux-foundation.org>;
	Thu, 13 Jun 2019 15:46:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from ale.deltatee.com (ale.deltatee.com [207.54.116.67])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 2814B775
	for <iommu@lists.linux-foundation.org>;
	Thu, 13 Jun 2019 15:46:57 +0000 (UTC)
Received: from s01061831bf6ec98c.cg.shawcable.net ([68.147.80.180]
	helo=[192.168.6.132]) by ale.deltatee.com with esmtpsa
	(TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.89)
	(envelope-from <logang@deltatee.com>)
	id 1hbRwA-0008JX-LL; Thu, 13 Jun 2019 09:46:51 -0600
To: Jon Mason <jdmason@kudzu.us>
References: <20190523223100.5526-1-logang@deltatee.com>
	<20190613133014.GE1572@kudzu.us>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <985a41a9-80c2-7b60-da98-4ea92085319b@deltatee.com>
Date: Thu, 13 Jun 2019 09:46:44 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190613133014.GE1572@kudzu.us>
Content-Language: en-US
X-SA-Exim-Connect-IP: 68.147.80.180
X-SA-Exim-Rcpt-To: epilmore@gigaio.com, fancer.lancer@gmail.com,
	dave.jiang@intel.com, allenbh@gmail.com, bhelgaas@google.com,
	joro@8bytes.org, linux-kselftest@vger.kernel.org,
	iommu@lists.linux-foundation.org, linux-pci@vger.kernel.org,
	linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org,
	jdmason@kudzu.us
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH v5 00/10] Support using MSI interrupts in ntb_transport
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Cc: Allen Hubbe <allenbh@gmail.com>, Dave Jiang <dave.jiang@intel.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Serge Semin <fancer.lancer@gmail.com>, Eric Pilmore <epilmore@gigaio.com>,
	iommu@lists.linux-foundation.org, linux-kselftest@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>, linux-ntb@googlegroups.com
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org



On 2019-06-13 7:30 a.m., Jon Mason wrote:
> On Thu, May 23, 2019 at 04:30:50PM -0600, Logan Gunthorpe wrote:
>> This is another resend as there has been no feedback since v4.
>> Seems Jon has been MIA this past cycle so hopefully he appears on the
>> list soon.
>>
>> I've addressed the feedback so far and rebased on the latest kernel
>> and would like this to be considered for merging this cycle.
>>
>> The only outstanding issue I know of is that it still will not work
>> with IDT hardware, but ntb_transport doesn't work with IDT hardware
>> and there is still no sensible common infrastructure to support
>> ntb_peer_mw_set_trans(). Thus, I decline to consider that complication
>> in this patchset. However, I'll be happy to review work that adds this
>> feature in the future.
>>
>> Also, as the port number and resource index stuff is a bit complicated,
>> I made a quick out of tree test fixture to ensure it's correct[1]. As
>> an excerise I also wrote some test code[2] using the upcomming KUnit
>> feature.
> 
> Sorry for the delay.  The patch is now in the ntb-next branch.  We've
> missed window for 5.2, but it will be in the 5.3 pull request (barring
> last minute comments).

Thanks Jon!

Logan
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
