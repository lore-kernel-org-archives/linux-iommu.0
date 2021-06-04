Return-Path: <SRS0=eMD9=K6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF150C4743C
	for <iommu@archiver.kernel.org>; Fri,  4 Jun 2021 17:25:18 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80C1261402
	for <iommu@archiver.kernel.org>; Fri,  4 Jun 2021 17:25:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80C1261402
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 4AE3640668;
	Fri,  4 Jun 2021 17:25:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IWrqQOEkPw6G; Fri,  4 Jun 2021 17:25:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id A64FB41DB1;
	Fri,  4 Jun 2021 17:25:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 76C62C000D;
	Fri,  4 Jun 2021 17:25:13 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CAC40C0001
 for <iommu@lists.linux-foundation.org>; Fri,  4 Jun 2021 17:25:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A9954843DF
 for <iommu@lists.linux-foundation.org>; Fri,  4 Jun 2021 17:25:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SDR1HyqHEbBw for <iommu@lists.linux-foundation.org>;
 Fri,  4 Jun 2021 17:25:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2C051843E1
 for <iommu@lists.linux-foundation.org>; Fri,  4 Jun 2021 17:25:05 +0000 (UTC)
IronPort-SDR: +mwKOmxxnBbrkBG2nRum38iDbZReD6t+X5AdPOU5Zpnzc/APmoJAQNZxI8JZ5HOGZKtH9gytfl
 RW8uRnLhZWZA==
X-IronPort-AV: E=McAfee;i="6200,9189,10005"; a="289965326"
X-IronPort-AV: E=Sophos;i="5.83,248,1616482800"; d="scan'208";a="289965326"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jun 2021 10:25:05 -0700
IronPort-SDR: dAFKNKjtmaL7yQnr3K/eB0SbWboMG8HyiCrjLVTN866KgoOVn5Xfj6lI+c9gQvaihlmzACMUqi
 AwFe9T7+EZTg==
X-IronPort-AV: E=Sophos;i="5.83,248,1616482800"; d="scan'208";a="401025402"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
 by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jun 2021 10:25:05 -0700
Date: Fri, 4 Jun 2021 10:27:43 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [RFC] /dev/ioasid uAPI proposal
Message-ID: <20210604102743.0bebc26a@jacob-builder>
In-Reply-To: <20210604120555.GH1002214@nvidia.com>
References: <MWHPR11MB1886422D4839B372C6AB245F8C239@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210528195839.GO1002214@nvidia.com> <YLcpw5Kx61L7TVmR@yekko>
 <20210602165838.GA1002214@nvidia.com> <YLhsZRc72aIMZajz@yekko>
 <YLn/SJtzuJopSO2x@myrica> <20210604120555.GH1002214@nvidia.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, "Tian,
 Kevin" <kevin.tian@intel.com>, "Alex Williamson
 \(alex.williamson@redhat.com\)" <alex.williamson@redhat.com>, "Raj,
 Ashok" <ashok.raj@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Robin Murphy <robin.murphy@arm.com>,
 LKML <linux-kernel@vger.kernel.org>, Kirti Wankhede <kwankhede@nvidia.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "Jiang,
 Dave" <dave.jiang@intel.com>, David Gibson <david@gibson.dropbear.id.au>,
 David Woodhouse <dwmw2@infradead.org>, Jason Wang <jasowang@redhat.com>
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

Hi Jason,

On Fri, 4 Jun 2021 09:05:55 -0300, Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Fri, Jun 04, 2021 at 12:24:08PM +0200, Jean-Philippe Brucker wrote:
> 
> > I think once it binds a device to an IOASID fd, QEMU will want to probe
> > what hardware features are available before going further with the
> > vIOMMU setup (is there PASID, PRI, which page table formats are
> > supported,  
> 
> I think David's point was that qemu should be told what vIOMMU it is
> emulating exactly (right down to what features it has) and then
> the goal is simply to match what the vIOMMU needs with direct HW
> support via /dev/ioasid and fall back to SW emulation when not
> possible.
> 
> If qemu wants to have some auto-configuration: 'pass host IOMMU
> capabilities' similar to the CPU flags then qemu should probe the
> /dev/ioasid - and maybe we should just return some highly rolled up
> "this is IOMMU HW ID ARM SMMU vXYZ" out of some query to guide qemu in
> doing this.
> 
There can be mixed types of physical IOMMUs on the host. So not until a
device is attached, we would not know if the vIOMMU can match the HW
support of the device's IOMMU. Perhaps, vIOMMU should check the
least common denominator features before commit.

Thanks,

Jacob
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
