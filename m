Return-Path: <SRS0=FkPa=NQ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0715C4338F
	for <iommu@archiver.kernel.org>; Wed, 25 Aug 2021 02:11:02 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D6EB61040
	for <iommu@archiver.kernel.org>; Wed, 25 Aug 2021 02:11:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8D6EB61040
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=apertussolutions.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 53D9240505;
	Wed, 25 Aug 2021 02:11:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qzx89sSrGLsw; Wed, 25 Aug 2021 02:10:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id E490E40506;
	Wed, 25 Aug 2021 02:10:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A1F8EC001A;
	Wed, 25 Aug 2021 02:10:57 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 852C3C000E
 for <iommu@lists.linux-foundation.org>; Wed, 25 Aug 2021 02:10:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6EB0F40506
 for <iommu@lists.linux-foundation.org>; Wed, 25 Aug 2021 02:10:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1eoblUHoVwNa for <iommu@lists.linux-foundation.org>;
 Wed, 25 Aug 2021 02:10:52 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from sender4-of-o51.zoho.com (sender4-of-o51.zoho.com
 [136.143.188.51])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8EF8140505
 for <iommu@lists.linux-foundation.org>; Wed, 25 Aug 2021 02:10:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1629857426; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=iPNY0Lm2xQU0W7XwDtIE6SOu4GH5QePOWGUQs6Qg0U9PONN9gPMfg5XPiO8SxxbBlVCx6bXt+ta8bmcYtmSrWI0voDWKOl2TC8Khu4j88Xz0jQtpnoPtGx1f2Fpx2qSpx5nQfOp75vjgHX3zwxYPImoshHS0+sMCg8Urj7owoXk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1629857426;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To;
 bh=EW4MjGTVwYJgE+935/0lwYuBbIgSXYbtlsZKkKFkB0w=; 
 b=kHJL6VY2fb9JQ2ce5pYYg4xiqFRZkn3QlLPKMIT+MV4WVpPBFH9oEhayRDN/iW4lavPb4wiTkTAXR7z+7LDpw/xrvTQqBNZAkeJmuxbPw8LL3KQHFV7kGJ2SgmurnDzGQSY3mVL07WZI7cC3BOuhLp3Eu6Lc9gy2wuyhf8AiHMY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=apertussolutions.com;
 spf=pass  smtp.mailfrom=dpsmith@apertussolutions.com;
 dmarc=pass header.from=<dpsmith@apertussolutions.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1629857426; 
 s=zoho; d=apertussolutions.com; i=dpsmith@apertussolutions.com;
 h=To:Cc:References:From:Subject:Message-ID:Date:MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding;
 bh=EW4MjGTVwYJgE+935/0lwYuBbIgSXYbtlsZKkKFkB0w=;
 b=pBV8y4/4zpYQsPzg6Kg66nRFWqt75lKoC9oHsHtBErzcAVDWx9qqTY1/m228IOze
 441OLy1hueS22Lxu8nHK2P5hs4acGvXFkGYU+QhMwsjScWJa0anUR1LXaA8uuE5RCPH
 GQYkJkzPxmjt58KNVgkd5OWLDfhXOp53oNiWUXcA=
Received: from [10.10.1.24] (static-72-81-132-2.bltmmd.fios.verizon.net
 [72.81.132.2]) by mx.zohomail.com
 with SMTPS id 162985742413164.47891803749803;
 Tue, 24 Aug 2021 19:10:24 -0700 (PDT)
To: Jarkko Sakkinen <jarkko@kernel.org>,
 Ross Philipson <ross.philipson@oracle.com>
References: <1628527136-2478-1-git-send-email-ross.philipson@oracle.com>
 <20210810162320.6rfpvdvzgxi35ylx@kernel.org>
From: "Daniel P. Smith" <dpsmith@apertussolutions.com>
Subject: Re: [PATCH v3 00/14] x86: Trenchboot secure dynamic launch Linux
 kernel support
Message-ID: <1de59a4d-b29f-2a67-1cbe-8d5f80e59ba5@apertussolutions.com>
Date: Tue, 24 Aug 2021 22:10:21 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210810162320.6rfpvdvzgxi35ylx@kernel.org>
Content-Language: en-US
X-ZohoMailClient: External
Cc: linux-doc@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org,
 luto@amacapital.net, iommu@lists.linux-foundation.org, mingo@redhat.com,
 bp@alien8.de, hpa@zytor.com, kanth.ghatraju@oracle.com,
 linux-integrity@vger.kernel.org, trenchboot-devel@googlegroups.com,
 tglx@linutronix.de
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 8/10/21 12:23 PM, Jarkko Sakkinen wrote:
> On Mon, Aug 09, 2021 at 12:38:42PM -0400, Ross Philipson wrote:
>> The focus of Trechboot project (https://github.com/TrenchBoot) is to
>> enhance the boot security and integrity. This requires the linux kernel
>                                                              ~~~~~
>                                                              Linux
> 
> How does it enhance it? The following sentence explains the requirements
> for the Linux kernel, i.e. it's a question without answer. And if there
> is no answer, there is no need to merge this.

We have added a documentation patch that provides background
information, an overview of the capability, and details about the
implementation. We can reword the cover letter, adding reference to this
documentation. And ack on fixing the incorrect case on Linux.

V/r
dps
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
