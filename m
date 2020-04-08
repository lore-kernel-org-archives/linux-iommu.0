Return-Path: <SRS0=CWSE=5Y=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_FONT_FACE_BAD,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_KAM_HTML_FONT_INVALID autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32ACCC2D0EA
	for <iommu@archiver.kernel.org>; Wed,  8 Apr 2020 11:26:52 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4BC520753
	for <iommu@archiver.kernel.org>; Wed,  8 Apr 2020 11:26:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4BC520753
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id B645585CDB;
	Wed,  8 Apr 2020 11:26:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QEMKJDYVHcMB; Wed,  8 Apr 2020 11:26:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 7B09485A32;
	Wed,  8 Apr 2020 11:26:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6609AC1AE8;
	Wed,  8 Apr 2020 11:26:49 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2FDD8C0177
 for <iommu@lists.linux-foundation.org>; Wed,  8 Apr 2020 11:26:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 13F028426E
 for <iommu@lists.linux-foundation.org>; Wed,  8 Apr 2020 11:26:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ahVMiBMxTdvB for <iommu@lists.linux-foundation.org>;
 Wed,  8 Apr 2020 11:26:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from cmccmta3.chinamobile.com (cmccmta3.chinamobile.com
 [221.176.66.81])
 by whitealder.osuosl.org (Postfix) with ESMTP id 4238E84189
 for <iommu@lists.linux-foundation.org>; Wed,  8 Apr 2020 11:26:38 +0000 (UTC)
Received: from spf.mail.chinamobile.com (unknown[172.16.121.5]) by
 rmmx-syy-dmz-app10-12010 (RichMail) with SMTP id 2eea5e8db4cec97-d1e28;
 Wed, 08 Apr 2020 19:26:07 +0800 (CST)
X-RM-TRANSID: 2eea5e8db4cec97-d1e28
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from DESKTOP-6DMC7FM (unknown[112.25.154.146])
 by rmsmtp-syy-appsvr03-12003 (RichMail) with SMTP id 2ee35e8db4cddc5-984aa;
 Wed, 08 Apr 2020 19:26:06 +0800 (CST)
X-RM-TRANSID: 2ee35e8db4cddc5-984aa
Date: Wed, 8 Apr 2020 19:27:53 +0800
From: "Tang Bin" <tangbin@cmss.chinamobile.com>
To: "Bjorn Andersson" <bjorn.andersson@linaro.org>
Subject: Re: Re: [PATCH] iommu/qcom:fix local_base status check
References: <20200402063302.20640-1-tangbin@cmss.chinamobile.com>, 
 <20200402064552.GG663905@yoga>
X-Priority: 3
X-GUID: 647BF68E-BD6A-4513-8DCE-AA7A046A9BFB
X-Has-Attach: no
X-Mailer: Foxmail 7.2.15.80[cn]
Mime-Version: 1.0
Message-ID: <2020040819275303590511@cmss.chinamobile.com>
Cc: linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 iommu <iommu@lists.linux-foundation.org>,
 linux-kernel <linux-kernel@vger.kernel.org>, agross <agross@kernel.org>
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
Content-Type: multipart/mixed; boundary="===============7011506084576707218=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

This is a multi-part message in MIME format.

--===============7011506084576707218==
Content-Type: multipart/alternative;
	boundary="----=_001_NextPart535205562787_=----"

This is a multi-part message in MIME format.

------=_001_NextPart535205562787_=----
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64

PiBSZXZpZXdlZC1ieTpCam9ybiBBbmRlcnNzb24gPGJqb3JuLmFuZGVyc3NvbkBsaW5hcm8ub3Jn
Pg0KDQpUaGFua3MgZm9yIHlvdXIgcG9zaXRpdmUgZmVlZGJhY2suDQoNCldpbGwgdGhlIHBhdGNo
IG5lZWQgYW55IG1vcmUgY2xhcmlmaWNhdGlvbu+8n0xvb2tpbmcgZm9yd2FyZCB0byB5b3VyIHJl
c3VsdCwgdGhhbmsgeW91IQ0KDQoNCg0KUmVnYXJkcywNClRhbmcgQmluDQogDQpGcm9tOiBCam9y
biBBbmRlcnNzb24NCkRhdGU6IDIwMjAtMDQtMDIgMTQ6NDUNClRvOiBUYW5nIEJpbg0KQ0M6IGFn
cm9zczsgcm9iZGNsYXJrOyBqb3JvOyBsaW51eC1hcm0tbXNtOyBpb21tdTsgbGludXgta2VybmVs
DQpTdWJqZWN0OiBSZTogW1BBVENIXSBpb21tdS9xY29tOmZpeCBsb2NhbF9iYXNlIHN0YXR1cyBj
aGVjaw0KT24gV2VkIDAxIEFwciAyMzozMyBQRFQgMjAyMCwgVGFuZyBCaW4gd3JvdGU6DQogDQo+
IFJlbGVhc2UgcmVzb3VyY2VzIHdoZW4gZXhpdGluZyBvbiBlcnJvci4NCj4gDQogDQpSZXZpZXdl
ZC1ieTogQmpvcm4gQW5kZXJzc29uIDxiam9ybi5hbmRlcnNzb25AbGluYXJvLm9yZz4NCiANClJl
Z2FyZHMsDQpCam9ybg0KIA0KPiBTaWduZWQtb2ZmLWJ5OiBUYW5nIEJpbiA8dGFuZ2JpbkBjbXNz
LmNoaW5hbW9iaWxlLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL2lvbW11L3Fjb21faW9tbXUuYyB8
IDUgKysrKy0NCj4gIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24o
LSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lvbW11L3Fjb21faW9tbXUuYyBiL2RyaXZl
cnMvaW9tbXUvcWNvbV9pb21tdS5jDQo+IGluZGV4IDQzMjhkYTBiMC4uYzA4YWE5NjUxIDEwMDY0
NA0KPiAtLS0gYS9kcml2ZXJzL2lvbW11L3Fjb21faW9tbXUuYw0KPiArKysgYi9kcml2ZXJzL2lv
bW11L3Fjb21faW9tbXUuYw0KPiBAQCAtODEzLDggKzgxMywxMSBAQCBzdGF0aWMgaW50IHFjb21f
aW9tbXVfZGV2aWNlX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ICBxY29t
X2lvbW11LT5kZXYgPSBkZXY7DQo+ICANCj4gIHJlcyA9IHBsYXRmb3JtX2dldF9yZXNvdXJjZShw
ZGV2LCBJT1JFU09VUkNFX01FTSwgMCk7DQo+IC0gaWYgKHJlcykNCj4gKyBpZiAocmVzKSB7DQo+
ICBxY29tX2lvbW11LT5sb2NhbF9iYXNlID0gZGV2bV9pb3JlbWFwX3Jlc291cmNlKGRldiwgcmVz
KTsNCj4gKyBpZiAoSVNfRVJSKHFjb21faW9tbXUtPmxvY2FsX2Jhc2UpKQ0KPiArIHJldHVybiBQ
VFJfRVJSKHFjb21faW9tbXUtPmxvY2FsX2Jhc2UpOw0KPiArIH0NCj4gIA0KPiAgcWNvbV9pb21t
dS0+aWZhY2VfY2xrID0gZGV2bV9jbGtfZ2V0KGRldiwgImlmYWNlIik7DQo+ICBpZiAoSVNfRVJS
KHFjb21faW9tbXUtPmlmYWNlX2NsaykpIHsNCj4gLS0gDQo+IDIuMjAuMS53aW5kb3dzLjENCj4g
DQo+IA0KPiANCg==

------=_001_NextPart535205562787_=----
Content-Type: text/html;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<html><head><meta http-equiv=3D"content-type" content=3D"text/html; charse=
t=3Dutf-8"><style>body { line-height: 1.5; }blockquote { margin-top: 0px; =
margin-bottom: 0px; margin-left: 0.5em; }body { font-size: 10.5pt; font-fa=
mily: 'Microsoft YaHei UI'; color: rgb(0, 0, 0); line-height: 1.5; }</styl=
e></head><body>=0A<div><span></span></div><div><div><span style=3D"color: =
rgb(128, 128, 128); font-family: =E5=BE=AE=E8=BD=AF=E9=9B=85=E9=BB=91; lin=
e-height: normal; font-size: 10.5pt; background-color: transparent;">&gt; =
Reviewed-by</span><font color=3D"#808080" face=3D"=E5=BE=AE=E8=BD=AF=E9=9B=
=85=E9=BB=91"><span style=3D"line-height: normal;">:</span>Bjorn Andersson=
 &lt;bjorn.andersson@linaro.org&gt;</font></div></div>=0A<div><br></div><d=
iv><div style=3D"font-family: 'Microsoft YaHei UI', Tahoma; line-height: n=
ormal;">Thanks for your positive feedback.</div></div><div><br></div><div>=
Will the patch need any more clarification=EF=BC=9FLooking forward to your=
 result, thank you!</div><div><br></div><hr style=3D"width: 210px; height:=
 1px;" color=3D"#b5c4df" size=3D"1" align=3D"left">=0A<div><span><div styl=
e=3D"MARGIN: 10px; FONT-FAMILY: verdana; FONT-SIZE: 10pt"><div style=3D"fo=
nt-family: 'Microsoft YaHei UI'; font-size: 14px; color: rgb(0, 0, 255); l=
ine-height: normal;"><div style=3D"color: rgb(0, 0, 0); line-height: 21px;=
"><span style=3D"font-family: 'Microsoft YaHei UI', Tahoma; line-height: n=
ormal;">Regards,</span></div><div style=3D"color: rgb(0, 0, 0); line-heigh=
t: 21px;"><span style=3D"font-family: 'Microsoft YaHei UI', Tahoma; line-h=
eight: normal;">Tang Bin</span></div></div></div></span></div>=0A<blockquo=
te style=3D"margin-Top: 0px; margin-Bottom: 0px; margin-Left: 0.5em"><div>=
&nbsp;</div><div style=3D"border:none;border-top:solid #B5C4DF 1.0pt;paddi=
ng:3.0pt 0cm 0cm 0cm"><div style=3D"PADDING-RIGHT: 8px; PADDING-LEFT: 8px;=
 FONT-SIZE: 12px;FONT-FAMILY:tahoma;COLOR:#000000; BACKGROUND: #efefef; PA=
DDING-BOTTOM: 8px; PADDING-TOP: 8px"><div><b>From:</b>&nbsp;<a href=3D"mai=
lto:bjorn.andersson@linaro.org">Bjorn Andersson</a></div><div><b>Date:</b>=
&nbsp;2020-04-02&nbsp;14:45</div><div><b>To:</b>&nbsp;<a href=3D"mailto:ta=
ngbin@cmss.chinamobile.com">Tang Bin</a></div><div><b>CC:</b>&nbsp;<a href=
=3D"mailto:agross@kernel.org">agross</a>; <a href=3D"mailto:robdclark@gmai=
l.com">robdclark</a>; <a href=3D"mailto:joro@8bytes.org">joro</a>; <a href=
=3D"mailto:linux-arm-msm@vger.kernel.org">linux-arm-msm</a>; <a href=3D"ma=
ilto:iommu@lists.linux-foundation.org">iommu</a>; <a href=3D"mailto:linux-=
kernel@vger.kernel.org">linux-kernel</a></div><div><b>Subject:</b>&nbsp;Re=
: [PATCH] iommu/qcom:fix local_base status check</div></div></div><div><di=
v>On Wed 01 Apr 23:33 PDT 2020, Tang Bin wrote:</div>=0A<div>&nbsp;</div>=
=0A<div>&gt; Release resources when exiting on error.</div>=0A<div>&gt; </=
div>=0A<div>&nbsp;</div>=0A<div>Reviewed-by: Bjorn Andersson &lt;bjorn.and=
ersson@linaro.org&gt;</div>=0A<div>&nbsp;</div>=0A<div>Regards,</div>=0A<d=
iv>Bjorn</div>=0A<div>&nbsp;</div>=0A<div>&gt; Signed-off-by: Tang Bin &lt=
;tangbin@cmss.chinamobile.com&gt;</div>=0A<div>&gt; ---</div>=0A<div>&gt;&=
nbsp; drivers/iommu/qcom_iommu.c | 5 ++++-</div>=0A<div>&gt;&nbsp; 1 file =
changed, 4 insertions(+), 1 deletion(-)</div>=0A<div>&gt; </div>=0A<div>&g=
t; diff --git a/drivers/iommu/qcom_iommu.c b/drivers/iommu/qcom_iommu.c</d=
iv>=0A<div>&gt; index 4328da0b0..c08aa9651 100644</div>=0A<div>&gt; --- a/=
drivers/iommu/qcom_iommu.c</div>=0A<div>&gt; +++ b/drivers/iommu/qcom_iomm=
u.c</div>=0A<div>&gt; @@ -813,8 +813,11 @@ static int qcom_iommu_device_pr=
obe(struct platform_device *pdev)</div>=0A<div>&gt;&nbsp; 	qcom_iommu-&gt;=
dev =3D dev;</div>=0A<div>&gt;&nbsp; </div>=0A<div>&gt;&nbsp; 	res =3D pla=
tform_get_resource(pdev, IORESOURCE_MEM, 0);</div>=0A<div>&gt; -	if (res)<=
/div>=0A<div>&gt; +	if (res) {</div>=0A<div>&gt;&nbsp; 		qcom_iommu-&gt;lo=
cal_base =3D devm_ioremap_resource(dev, res);</div>=0A<div>&gt; +		if (IS_=
ERR(qcom_iommu-&gt;local_base))</div>=0A<div>&gt; +			return PTR_ERR(qcom_=
iommu-&gt;local_base);</div>=0A<div>&gt; +	}</div>=0A<div>&gt;&nbsp; </div=
>=0A<div>&gt;&nbsp; 	qcom_iommu-&gt;iface_clk =3D devm_clk_get(dev, "iface=
");</div>=0A<div>&gt;&nbsp; 	if (IS_ERR(qcom_iommu-&gt;iface_clk)) {</div>=
=0A<div>&gt; -- </div>=0A<div>&gt; 2.20.1.windows.1</div>=0A<div>&gt; </di=
v>=0A<div>&gt; </div>=0A<div>&gt; </div>=0A</div></blockquote>=0A</body></=
html>
------=_001_NextPart535205562787_=------




--===============7011506084576707218==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============7011506084576707218==--



