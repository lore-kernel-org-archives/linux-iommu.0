Return-Path: <SRS0=ZsFK=UJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BB34C468BC
	for <iommu@archiver.kernel.org>; Mon, 10 Jun 2019 05:04:01 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F1EE2085A
	for <iommu@archiver.kernel.org>; Mon, 10 Jun 2019 05:04:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F1EE2085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 3EA4EB7D;
	Mon, 10 Jun 2019 05:04:01 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 71A2E2C
	for <iommu@lists.linux-foundation.org>;
	Sun,  9 Jun 2019 03:27:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id F3E11775
	for <iommu@lists.linux-foundation.org>;
	Sun,  9 Jun 2019 03:27:42 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
	by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	08 Jun 2019 20:27:41 -0700
X-ExtLoop1: 1
Received: from allen-box.sh.intel.com (HELO [10.239.159.136])
	([10.239.159.136])
	by orsmga004.jf.intel.com with ESMTP; 08 Jun 2019 20:27:38 -0700
Subject: Re: Device specific pass through in host systems - discuss user
	interface
To: "Prakhya, Sai Praneeth" <sai.praneeth.prakhya@intel.com>,
	"iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
References: <FFF73D592F13FD46B8700F0A279B802F48DA796E@ORSMSX114.amr.corp.intel.com>
From: "Lu, Baolu" <baolu.lu@intel.com>
Message-ID: <b7a71b22-aa3b-5ac3-7285-5231f84ee979@intel.com>
Date: Sun, 9 Jun 2019 11:20:34 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <FFF73D592F13FD46B8700F0A279B802F48DA796E@ORSMSX114.amr.corp.intel.com>
Content-Language: en-US
X-Mailman-Approved-At: Mon, 10 Jun 2019 05:04:00 +0000
Cc: "Shankar, Ravi V" <ravi.v.shankar@intel.com>, "Tian,
	Kevin" <kevin.tian@intel.com>, "jroedel@suse.de" <jroedel@suse.de>, "Raj,
	Ashok" <ashok.raj@intel.com>, Will Deacon <will.deacon@arm.com>,
	"Pan, Jacob jun" <jacob.jun.pan@intel.com>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>, "hch@lst.de" <hch@lst.de>
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
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="windows-1252"; Format="flowed"
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

Hi Sai,


On 6/7/19 10:24 AM, Prakhya, Sai Praneeth wrote:
> Hi All,
> =

> I am working on an IOMMU driver feature that allows a user to specify if =

> the DMA from a device should be translated by IOMMU or not. Presently, =

> we support only all devices or none mode i.e. if user specifies =

> =93iommu=3Dpt=94 [X86] or =93iommu.passthrough=94 [ARM64] through kernel =
command =

> line, all the devices would be in pass through mode and we don=92t have =

> per device granularity, but, we were requested by a customer to =

> selectively put devices in pass through mode and not all.

Most iommu vendor drivers have switched from per-device to per-group
domain (a.k.a. default domain). So per-group pass-through mode makes
more sense?

By the way, can we extend this to "per-group default domain type",
instead of only "per-group pass-through mode"? Currently we have system
level default domain type, if we have finer granularity of default
domain type, both iommu drivers and end users will benefit from it.

> =

> Since, this feature could be generic across architectures, we thought it =

> would be better if the user interface is discussed in the community =

> first. We are envisioning this to be used both during boot time and =

> runtime and hence having a kernel command line argument along with a =

> sysfs entry are needed. So, please pour in your suggestions on how the =

> user interface should look like to make it architecture agnostic.
> =

> 1.Have a kernel command line argument that takes a list of BDF=92s as an =

> input and puts them in pass through mode
> =

> a.Accepting BDF as an input has a downside =96 BDF is dynamic and could =

> change if BIOS/OS enumerates a new device in next reboot
> =

> b.Accepting <vendor_id:device_id> pair as an input has a downside =96 Wha=
t =

> to do when there are multiple such devices and user would like to put =

> only some of them in PT mode
> =

> 2.Have a sysfs file which takes 1 or 0 as an input to enable/disable =

> pass through mode. Some places that seem to be reasonable are
> =

> a./sys/class/iommu/dmar0/devices/
> =

> b./sys/kernel/iommu_groups/<id>/devices
> =

> I am looking for a consensus on **how the kernel command line argument =

> should look like and path for sysfs entry**. Also, please note that if a =

> device is put in pass through mode it won=92t be available for the guest =

> and that=92s ok.

Just out of curiosity, what's the limitation for a device using pass-
through DMA domain to be assignable.

Best regards,
Baolu

> =

> Regards,
> =

> Sai
> =

> PS: Idea credits: Ashok Raj
> =

> =

> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
> =

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
