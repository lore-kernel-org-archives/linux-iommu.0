Return-Path: <SRS0=AgN4=X4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16A5AC32792
	for <iommu@archiver.kernel.org>; Thu,  3 Oct 2019 22:24:57 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1CE620700
	for <iommu@archiver.kernel.org>; Thu,  3 Oct 2019 22:24:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1CE620700
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id ADDE9166C;
	Thu,  3 Oct 2019 22:24:56 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id DD762E7D
	for <iommu@lists.linux-foundation.org>;
	Thu,  3 Oct 2019 22:24:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id F06A7D3
	for <iommu@lists.linux-foundation.org>;
	Thu,  3 Oct 2019 22:24:54 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 028501000;
	Thu,  3 Oct 2019 15:24:54 -0700 (PDT)
Received: from [192.168.1.124] (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3D2603F534;
	Thu,  3 Oct 2019 15:24:51 -0700 (PDT)
Subject: Re: [PATCH v2] iommu/arm-smmu: Break insecure users by disabling
	bypass by default
To: Tim Harvey <tharvey@gateworks.com>
References: <20190301192017.39770-1-dianders@chromium.org>
	<CAJ+vNU0Ma5nG9_ThLO4cdO+=ivf7rmXiHZonF0HY0xx6X3R6Hw@mail.gmail.com>
	<5dce2964-8761-e7d0-8963-f0f5cb2feb02@arm.com>
	<CAJ+vNU0Q1-d7YDbAAEMqEcWnniqo6jLdKBbcUTar5=hJ+AC8vQ@mail.gmail.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <1f6f7eb0-e1dc-d5a8-fb38-44c5bd839894@arm.com>
Date: Thu, 3 Oct 2019 23:24:48 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
	Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CAJ+vNU0Q1-d7YDbAAEMqEcWnniqo6jLdKBbcUTar5=hJ+AC8vQ@mail.gmail.com>
Content-Language: en-GB
Cc: open list <linux-kernel@vger.kernel.org>, linux-arm-msm@vger.kernel.org,
	Will Deacon <will.deacon@arm.com>,
	Douglas Anderson <dianders@chromium.org>, evgreen@chromium.org,
	iommu@lists.linux-foundation.org,
	Vivek Gautam <vivek.gautam@codeaurora.org>,
	Tirumalesh Chalamarla <tchalamarla@caviumnetworks.com>,
	linux-arm-kernel@lists.infradead.org
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

On 2019-10-03 9:51 pm, Tim Harvey wrote:
> On Thu, Oct 3, 2019 at 1:42 PM Robin Murphy <robin.murphy@arm.com> wrote:
>>
>> Hi Tim,
>>
>> On 2019-10-03 7:27 pm, Tim Harvey wrote:
>>> On Fri, Mar 1, 2019 at 11:21 AM Douglas Anderson <dianders@chromium.org> wrote:
>>>>
>>>> If you're bisecting why your peripherals stopped working, it's
>>>> probably this CL.  Specifically if you see this in your dmesg:
>>>>     Unexpected global fault, this could be serious
>>>> ...then it's almost certainly this CL.
>>>>
>>>> Running your IOMMU-enabled peripherals with the IOMMU in bypass mode
>>>> is insecure and effectively disables the protection they provide.
>>>> There are few reasons to allow unmatched stream bypass, and even fewer
>>>> good ones.
>>>>
>>>> This patch starts the transition over to make it much harder to run
>>>> your system insecurely.  Expected steps:
>>>>
>>>> 1. By default disable bypass (so anyone insecure will notice) but make
>>>>      it easy for someone to re-enable bypass with just a KConfig change.
>>>>      That's this patch.
>>>>
>>>> 2. After people have had a little time to come to grips with the fact
>>>>      that they need to set their IOMMUs properly and have had time to
>>>>      dig into how to do this, the KConfig will be eliminated and bypass
>>>>      will simply be disabled.  Folks who are truly upset and still
>>>>      haven't fixed their system can either figure out how to add
>>>>      'arm-smmu.disable_bypass=n' to their command line or revert the
>>>>      patch in their own private kernel.  Of course these folks will be
>>>>      less secure.
>>>>
>>>> Suggested-by: Robin Murphy <robin.murphy@arm.com>
>>>> Signed-off-by: Douglas Anderson <dianders@chromium.org>
>>>> ---
>>>
>>> Hi Doug / Robin,
>>>
>>> I ran into this breaking things on OcteonTx boards based on CN80XX
>>> CPU. The IOMMU configuration is a bit beyond me and I'm hoping you can
>>> offer some advice. The IOMMU here is cavium,smmu-v2 as defined in
>>> https://github.com/Gateworks/dts-newport/blob/master/cn81xx-linux.dtsi
>>>
>>> Booting with 'arm-smmu.disable_bypass=n' does indeed work around the
>>> breakage as the commit suggests.
>>>
>>> Any suggestions for a proper fix?
>>
>> Ah, you're using the old "mmu-masters" binding (and in a way which isn't
>> well-defined - it's never been specified what the stream ID argument(s)
>> would mean for a PCI host bridge, and Linux just ignores them). The
>> ideal thing would be to update the DT to generic "iommu-map" properties
>> - it's been a long time since I last played with a ThunderX, but I
>> believe the SMMU stream IDs should just be the same as the ITS device
>> IDs (which is how the "mmu-masters" mapping would have played out anyway).
>>
>> The arm-smmu driver support for the old binding has always relied on
>> implicit bypass - there are technical reasons why we can't realistically
>> support the full functionality offered to the generic bindings, but it
>> would be possible to add some degree of workaround to prevent it
>> interacting quite so poorly with disable_bypass, if necessary. Do you
>> have deployed systems with DTs that can't be updated, but still might
>> need to run new kernels?
>>
> 
> Robin,
> 
> Thanks for the response. I don't care too much about supporting new
> kernels with the current DT - I'm good with fixing this with a DT
> change. Would you be able to give me an example? I would love to see
> Cavium mainline an cn81xx dts/dtsi in arch/arm64/boot/dts to be used
> as a base as the only thing we have to go off of currently is the
> Cavium SDK which has fairly old kernel support.

No promises (it's a late-night hack from my sofa), but try giving this a 
go...

Robin.

----->8-----
diff --git a/cn81xx-linux.dtsi b/cn81xx-linux.dtsi
index 3b759d9575fe..dabc9047c674 100644
--- a/cn81xx-linux.dtsi
+++ b/cn81xx-linux.dtsi
@@ -234,7 +234,7 @@
  			clocks = <&sclk>;
  		};

-		smmu0@830000000000 {
+		smmu: smmu0@830000000000 {
  			compatible = "cavium,smmu-v2";
  			reg = <0x8300 0x0 0x0 0x2000000>;
  			#global-interrupts = <1>;
@@ -249,23 +249,18 @@
  				     <0 69 4>, <0 69 4>, <0 69 4>, <0 69 4>, <0 69 4>, <0 69 4>,
  				     <0 69 4>, <0 69 4>, <0 69 4>, <0 69 4>, <0 69 4>, <0 69 4>,
  				     <0 69 4>, <0 69 4>, <0 69 4>, <0 69 4>, <0 69 4>;
-
-			mmu-masters = <&ecam0 0x100>,
-				      <&pem0  0x200>,
-				      <&pem1  0x300>,
-				      <&pem2  0x400>;
-
+			#iommu-cells = <1>;
+			dma-coherent;
  		};

  		ecam0: pci@848000000000 {
  			compatible = "pci-host-ecam-generic";
  			device_type = "pci";
-			msi-parent = <&its>;
  			msi-map = <0 &its 0 0x10000>;
+			iommu-map = <0 &smmu 0 0x10000>;
  			bus-range = <0 31>;
  			#size-cells = <2>;
  			#address-cells = <3>;
-			#stream-id-cells = <1>;
  			u-boot,dm-pre-reloc;
  			dma-coherent;
  			reg = <0x8480 0x00000000 0 0x02000000>;	 /* Configuration space */
@@ -399,12 +394,11 @@

  			compatible = "cavium,pci-host-thunder-pem";
  			device_type = "pci";
-			msi-parent = <&its>;
  			msi-map = <0 &its 0 0x10000>;
+			iommu-map = <0 &smmu 0 0x10000>;
  			bus-range = <0x1f 0x57>;
  			#size-cells = <2>;
  			#address-cells = <3>;
-			#stream-id-cells = <1>;
  			dma-coherent;
  			reg = <0x8800 0x1f000000 0x0 0x39000000>,  /* Configuration space */
  				<0x87e0 0xc0000000 0x0 0x01000000>; /* PEM space */
@@ -424,12 +418,11 @@
  		pem1: pci@87e0c1000000 {
  			compatible = "cavium,pci-host-thunder-pem";
  			device_type = "pci";
-			msi-parent = <&its>;
  			msi-map = <0 &its 0 0x10000>;
+			iommu-map = <0 &smmu 0 0x10000>;
  			bus-range = <0x57 0x8f>;
  			#size-cells = <2>;
  			#address-cells = <3>;
-			#stream-id-cells = <1>;
  			dma-coherent;
  			reg = <0x8840 0x57000000 0x0 0x39000000>,  /* Configuration space */
  				<0x87e0 0xc1000000 0x0 0x01000000>; /* PEM space */
@@ -449,12 +442,11 @@
  		pem2: pci@87e0c2000000 {
  			compatible = "cavium,pci-host-thunder-pem";
  			device_type = "pci";
-			msi-parent = <&its>;
  			msi-map = <0 &its 0 0x10000>;
+			iommu-map = <0 &smmu 0 0x10000>;
  			bus-range = <0x8f 0xc7>;
  			#size-cells = <2>;
  			#address-cells = <3>;
-			#stream-id-cells = <1>;
  			dma-coherent;
  			reg = <0x8880 0x8f000000 0x0 0x39000000>,  /* Configuration space */
  				<0x87e0 0xc2000000 0x0 0x01000000>; /* PEM space */
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
