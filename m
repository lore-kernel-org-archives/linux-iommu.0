Return-Path: <SRS0=5lac=W6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 620E8C3A5A8
	for <iommu@archiver.kernel.org>; Tue,  3 Sep 2019 06:40:57 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22F5D22DBF
	for <iommu@archiver.kernel.org>; Tue,  3 Sep 2019 06:40:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="CJNMYLqK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22F5D22DBF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id DEDABCA4;
	Tue,  3 Sep 2019 06:40:56 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 9DBD8C9E
	for <iommu@lists.linux-foundation.org>;
	Tue,  3 Sep 2019 06:40:55 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 55557887
	for <iommu@lists.linux-foundation.org>;
	Tue,  3 Sep 2019 06:40:55 +0000 (UTC)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
	bits)) (No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id 048432173E;
	Tue,  3 Sep 2019 06:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567492855;
	bh=Kjnhxdr190S6hyFGdIsCbzAIQoMLyHpi5BtCmbjQvfo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CJNMYLqKdbPFEmIjo2UcyeccD7qZ4BLQcspji35Bg8d5E5Cfx5WnE2mk2d8cDlg1T
	ZwfTmgVyXlwi1nUwRCoa62/pcsRd7iTbF88V4/6joXY7I95cZvmsCudYIkrgFAJJo8
	kPgaKEfu3M7dXQ6AotA/WJq4dpeaZY3h4hYgLX6k=
Date: Tue, 3 Sep 2019 07:40:51 +0100
From: Will Deacon <will@kernel.org>
To: Qian Cai <cai@lca.pw>
Subject: Re: "Rework enabling/disabling of ATS for PCI masters" failed to
	compile on arm64
Message-ID: <20190903064050.zsmaum4gajqjdivv@willie-the-truck>
References: <63FF6963-E1D9-4C65-AD2E-0E4938D08584@lca.pw>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <63FF6963-E1D9-4C65-AD2E-0E4938D08584@lca.pw>
User-Agent: NeoMutt/20170113 (1.7.2)
Cc: iommu@lists.linux-foundation.org, Joerg Roedel <jroedel@suse.de>,
	Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org,
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

T24gTW9uLCBTZXAgMDIsIDIwMTkgYXQgMTA6MTA6MzBQTSAtMDQwMCwgUWlhbiBDYWkgd3JvdGU6
Cj4gVGhlIGxpbnV4LW5leHQgY29tbWl0IOKAnGlvbW11L2FybS1zbW11LXYzOiBSZXdvcmsgZW5h
YmxpbmcvZGlzYWJsaW5nIG9mIEFUUyBmb3IgUENJIG1hc3RlcnPigJ0gWzFdIGNhdXNlcyBhIGNv
bXBpbGF0aW9uIGVycm9yIHdoZW4gUENJX0FUUz1uIG9uIGFybTY0Lgo+IAo+IFsxXSBodHRwczov
L2xvcmUua2VybmVsLm9yZy9saW51eC1pb21tdS8yMDE5MDgyMDE1NDU0OS4xNzAxOC0zLXdpbGxA
a2VybmVsLm9yZy8KPiAKPiBkcml2ZXJzL2lvbW11L2FybS1zbW11LXYzLmM6MjMyNTozNTogZXJy
b3I6IG5vIG1lbWJlciBuYW1lZCAnYXRzX2NhcCcgaW4gJ3N0cnVjdCBwY2lfZGV2Jwo+ICAgICAg
ICAgcmV0dXJuICFwZGV2LT51bnRydXN0ZWQgJiYgcGRldi0+YXRzX2NhcDsKPiAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIH5+fn4gIF4KPiAKPiBGb3IgZXhhbXBsZSwKPiAKPiBT
eW1ib2w6IFBDSV9BVFMgWz1uXQo+ICAg4pSCIFR5cGUgIDogYm9vbAo+ICAg4pSCICAgRGVmaW5l
ZCBhdCBkcml2ZXJzL3BjaS9LY29uZmlnOjExOAo+ICAg4pSCICAgRGVwZW5kcyBvbjogUENJIFs9
eV0gCj4gICDilIIgICBTZWxlY3RlZCBieSBbbl06IAo+ICAg4pSCICAgLSBQQ0lfSU9WIFs9bl0g
JiYgUENJIFs9eV0gCj4gICDilIIgICAtIFBDSV9QUkkgWz1uXSAmJiBQQ0kgWz15XeKUgiAgCj4g
ICDilIIgICAtIFBDSV9QQVNJRCBbPW5dICYmIFBDSSBbPXldIOKUgiAgCj4gICDilIIgICAtIEFN
RF9JT01NVSBbPW5dICYmIElPTU1VX1NVUFBPUlQgWz15XSAmJiBYODZfNjQgJiYgUENJIFs9eV0g
JiYgQUNQSSBbPXldCgpodHRwczovL2xrbWwua2VybmVsLm9yZy9yLzIwMTkwOTAzMDYzMDI4LjZy
eXVrNWRtYW9oaTJmcWFAd2lsbGllLXRoZS10cnVjawoKV2lsbApfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlz
dHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3Jn
L21haWxtYW4vbGlzdGluZm8vaW9tbXU=
