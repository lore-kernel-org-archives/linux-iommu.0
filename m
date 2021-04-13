Return-Path: <SRS0=gU7u=JK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91881C43460
	for <iommu@archiver.kernel.org>; Tue, 13 Apr 2021 17:53:32 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EEBFD613B6
	for <iommu@archiver.kernel.org>; Tue, 13 Apr 2021 17:53:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEBFD613B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 90D7340E71;
	Tue, 13 Apr 2021 17:53:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kC00tKWfrqdr; Tue, 13 Apr 2021 17:53:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id B993140E6A;
	Tue, 13 Apr 2021 17:53:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 98746C000B;
	Tue, 13 Apr 2021 17:53:29 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 957E3C000A
 for <iommu@lists.linux-foundation.org>; Tue, 13 Apr 2021 17:53:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7C26C84579
 for <iommu@lists.linux-foundation.org>; Tue, 13 Apr 2021 17:53:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1uEk67usBLfv for <iommu@lists.linux-foundation.org>;
 Tue, 13 Apr 2021 17:53:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from userp2120.oracle.com (userp2120.oracle.com [156.151.31.85])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8D04784576
 for <iommu@lists.linux-foundation.org>; Tue, 13 Apr 2021 17:53:27 +0000 (UTC)
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13DHZWXh006380;
 Tue, 13 Apr 2021 17:53:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : message-id :
 content-type : mime-version : subject : date : in-reply-to : cc : to :
 references; s=corp-2020-01-29;
 bh=UuNW+7uwvXfs4D5aydLi6MTfORxEtuXoAsmOKQNcpz0=;
 b=kqKMuCdbPSnSgCbbdCKB/snBWO/jiIBpZ7xB4i/GI/AYVBV1LYi5NmwSy3m33pVQkCTV
 cmxxKWR9C9KfrJYfkq+CVfmHO5KY1RpeWVFVAq2zyFKWw2OLSeJeatv3+ltgiW/LSfDL
 Af4OXcJg5rS2AgV+2CqSb7d2RRP4L0BZzzdAx4Kf0zHKnZ1EaM/5HVe2QKOt5gZxqHXF
 tDbrd3VErn2hzagczPCYRtuJ5HObTCmobQYf6tZmJ/QE6p81P3F2qjqJccoY7J8oidym
 dP1uWhibzVVrjtD1YitDDwebZjIQqlYXg+DUZA2fCXxUo5aYnjHle+M9LcHlM6Jqz1Ok fA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by userp2120.oracle.com with ESMTP id 37u4nnfxam-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 13 Apr 2021 17:53:14 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13DHZS9L057122;
 Tue, 13 Apr 2021 17:53:12 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by userp3020.oracle.com with ESMTP id 37unssq9xs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 13 Apr 2021 17:53:12 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 13DHr9ww028782;
 Tue, 13 Apr 2021 17:53:09 GMT
Received: from dhcp-10-159-224-82.vpn.oracle.com (/10.159.224.82)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Tue, 13 Apr 2021 17:53:09 +0000
From: Saeed Mirzamohammadi <saeed.mirzamohammadi@oracle.com>
Message-Id: <DD146005-CC5A-45E0-8E23-421051EE7FAD@oracle.com>
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [PATCH 5.4 v3 1/1] iommu/vt-d: Fix agaw for a supported 48 bit
 guest address width
Date: Tue, 13 Apr 2021 10:53:07 -0700
In-Reply-To: <YHVJDM4CXINrO1KE@kroah.com>
To: Greg KH <gregkh@linuxfoundation.org>
References: <20210412202736.70765-1-saeed.mirzamohammadi@oracle.com>
 <YHVJDM4CXINrO1KE@kroah.com>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Proofpoint-IMR: 1
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9953
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 adultscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 mlxscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104130120
X-Proofpoint-ORIG-GUID: LXI8C9aasPhkN6FiTis5pA02c4DgNhKB
X-Proofpoint-GUID: LXI8C9aasPhkN6FiTis5pA02c4DgNhKB
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9953
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 malwarescore=0
 phishscore=0 suspectscore=0 mlxlogscore=999 priorityscore=1501
 clxscore=1015 lowpriorityscore=0 spamscore=0 impostorscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104130120
Cc: Saeed Mirzamohammadi <saeed.mirzamohammadi@oracle.com>,
 Camille Lu <camille.lu@hpe.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "# v4 . 16+" <stable@vger.kernel.org>, iommu@lists.linux-foundation.org,
 David Woodhouse <dwmw2@infradead.org>
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
Content-Type: multipart/mixed; boundary="===============2729248921982906517=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============2729248921982906517==
Content-Type: multipart/alternative;
	boundary="Apple-Mail=_EC17D4B7-959B-4F5E-9BB0-64659F7F834B"


--Apple-Mail=_EC17D4B7-959B-4F5E-9BB0-64659F7F834B
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

Hi Greg,

I don=E2=80=99t have any commit ID since the fix is not in mainline or =
any Linus=E2=80=99 tree yet. The driver has completely changed for newer =
stable versions (and also mainline) and the fix only applies for 5.4, =
4.19, and 4.14 stable kernels.

Thanks,
Saeed


> On Apr 13, 2021, at 12:32 AM, Greg KH <gregkh@linuxfoundation.org> =
wrote:
>=20
> <meta comment, please fix your email client to put proper things in =
the
> To: line so that we can correctly respond to patches...>
>=20
> On Mon, Apr 12, 2021 at 01:27:35PM -0700, Saeed Mirzamohammadi wrote:
>> The IOMMU driver calculates the guest addressability for a DMA =
request
>> based on the value of the mgaw reported from the IOMMU. However, this
>> is a fused value and as mentioned in the spec, the guest width
>> should be calculated based on the minimum of supported adjusted guest
>> address width (SAGAW) and MGAW.
>>=20
>> This is from specification:
>> "Guest addressability for a given DMA request is limited to the
>> minimum of the value reported through this field and the adjusted
>> guest address width of the corresponding page-table structure.
>> (Adjusted guest address widths supported by hardware are reported
>> through the SAGAW field)."
>>=20
>> This causes domain initialization to fail and following
>> errors appear for EHCI PCI driver:
>>=20
>> [    2.486393] ehci-pci 0000:01:00.4: EHCI Host Controller
>> [    2.486624] ehci-pci 0000:01:00.4: new USB bus registered, =
assigned bus
>> number 1
>> [    2.489127] ehci-pci 0000:01:00.4: DMAR: Allocating domain failed
>> [    2.489350] ehci-pci 0000:01:00.4: DMAR: 32bit DMA uses =
non-identity
>> mapping
>> [    2.489359] ehci-pci 0000:01:00.4: can't setup: -12
>> [    2.489531] ehci-pci 0000:01:00.4: USB bus 1 deregistered
>> [    2.490023] ehci-pci 0000:01:00.4: init 0000:01:00.4 fail, -12
>> [    2.490358] ehci-pci: probe of 0000:01:00.4 failed with error -12
>>=20
>> This issue happens when the value of the sagaw corresponds to a
>> 48-bit agaw. This fix updates the calculation of the agaw based on
>> the minimum of IOMMU's sagaw value and MGAW.
>>=20
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Saeed Mirzamohammadi <saeed.mirzamohammadi@oracle.com>
>> Tested-by: Camille Lu <camille.lu@hpe.com>
>> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
>=20
> What is the git commit id of this patch in Linus's tree?
>=20
> thanks,
>=20
> greg k-h


--Apple-Mail=_EC17D4B7-959B-4F5E-9BB0-64659F7F834B
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=utf-8

<html><head><meta http-equiv=3D"Content-Type" content=3D"text/html; =
charset=3Dutf-8"></head><body style=3D"word-wrap: break-word; =
-webkit-nbsp-mode: space; line-break: after-white-space;" class=3D"">Hi =
Greg,<div class=3D""><br class=3D""></div><div class=3D""><div>I don=E2=80=
=99t have any commit ID since the fix is not in mainline or any Linus=E2=80=
=99 tree yet. The driver has completely changed for newer stable =
versions (and also mainline) and the fix only applies for 5.4, 4.19, and =
4.14 stable kernels.</div><div><br =
class=3D""></div><div>Thanks,</div><div>Saeed</div><div><br =
class=3D""></div><div><br class=3D""><blockquote type=3D"cite" =
class=3D""><div class=3D"">On Apr 13, 2021, at 12:32 AM, Greg KH &lt;<a =
href=3D"mailto:gregkh@linuxfoundation.org" =
class=3D"">gregkh@linuxfoundation.org</a>&gt; wrote:</div><br =
class=3D"Apple-interchange-newline"><div class=3D""><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: =
normal; letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;" class=3D"">&lt;meta comment, please fix =
your email client to put proper things in the</span><br =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: =
normal; letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none;" class=3D""><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: =
normal; letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;" class=3D"">To: line so that we can =
correctly respond to patches...&gt;</span><br style=3D"caret-color: =
rgb(0, 0, 0); font-family: Helvetica; font-size: 12px; font-style: =
normal; font-variant-caps: normal; font-weight: normal; letter-spacing: =
normal; text-align: start; text-indent: 0px; text-transform: none; =
white-space: normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;" class=3D""><br style=3D"caret-color: rgb(0, 0, =
0); font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;" class=3D""><span style=3D"caret-color: rgb(0, 0, =
0); font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none; float: none; display: inline !important;" =
class=3D"">On Mon, Apr 12, 2021 at 01:27:35PM -0700, Saeed =
Mirzamohammadi wrote:</span><br style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;" class=3D""><blockquote type=3D"cite" =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
orphans: auto; text-align: start; text-indent: 0px; text-transform: =
none; white-space: normal; widows: auto; word-spacing: 0px; =
-webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px; =
text-decoration: none;" class=3D"">The IOMMU driver calculates the guest =
addressability for a DMA request<br class=3D"">based on the value of the =
mgaw reported from the IOMMU. However, this<br class=3D"">is a fused =
value and as mentioned in the spec, the guest width<br class=3D"">should =
be calculated based on the minimum of supported adjusted guest<br =
class=3D"">address width (SAGAW) and MGAW.<br class=3D""><br =
class=3D"">This is from specification:<br class=3D"">"Guest =
addressability for a given DMA request is limited to the<br =
class=3D"">minimum of the value reported through this field and the =
adjusted<br class=3D"">guest address width of the corresponding =
page-table structure.<br class=3D"">(Adjusted guest address widths =
supported by hardware are reported<br class=3D"">through the SAGAW =
field)."<br class=3D""><br class=3D"">This causes domain initialization =
to fail and following<br class=3D"">errors appear for EHCI PCI =
driver:<br class=3D""><br class=3D"">[ &nbsp;&nbsp;&nbsp;2.486393] =
ehci-pci 0000:01:00.4: EHCI Host Controller<br class=3D"">[ =
&nbsp;&nbsp;&nbsp;2.486624] ehci-pci 0000:01:00.4: new USB bus =
registered, assigned bus<br class=3D"">number 1<br class=3D"">[ =
&nbsp;&nbsp;&nbsp;2.489127] ehci-pci 0000:01:00.4: DMAR: Allocating =
domain failed<br class=3D"">[ &nbsp;&nbsp;&nbsp;2.489350] ehci-pci =
0000:01:00.4: DMAR: 32bit DMA uses non-identity<br class=3D"">mapping<br =
class=3D"">[ &nbsp;&nbsp;&nbsp;2.489359] ehci-pci 0000:01:00.4: can't =
setup: -12<br class=3D"">[ &nbsp;&nbsp;&nbsp;2.489531] ehci-pci =
0000:01:00.4: USB bus 1 deregistered<br class=3D"">[ =
&nbsp;&nbsp;&nbsp;2.490023] ehci-pci 0000:01:00.4: init 0000:01:00.4 =
fail, -12<br class=3D"">[ &nbsp;&nbsp;&nbsp;2.490358] ehci-pci: probe of =
0000:01:00.4 failed with error -12<br class=3D""><br class=3D"">This =
issue happens when the value of the sagaw corresponds to a<br =
class=3D"">48-bit agaw. This fix updates the calculation of the agaw =
based on<br class=3D"">the minimum of IOMMU's sagaw value and MGAW.<br =
class=3D""><br class=3D"">Cc: <a href=3D"mailto:stable@vger.kernel.org" =
class=3D"">stable@vger.kernel.org</a><br class=3D"">Signed-off-by: Saeed =
Mirzamohammadi &lt;<a href=3D"mailto:saeed.mirzamohammadi@oracle.com" =
class=3D"">saeed.mirzamohammadi@oracle.com</a>&gt;<br =
class=3D"">Tested-by: Camille Lu &lt;<a href=3D"mailto:camille.lu@hpe.com"=
 class=3D"">camille.lu@hpe.com</a>&gt;<br class=3D"">Reviewed-by: Lu =
Baolu &lt;<a href=3D"mailto:baolu.lu@linux.intel.com" =
class=3D"">baolu.lu@linux.intel.com</a>&gt;<br class=3D""></blockquote><br=
 style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: =
normal; letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none;" class=3D""><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: =
normal; letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;" class=3D"">What is the git commit id of =
this patch in Linus's tree?</span><br style=3D"caret-color: rgb(0, 0, =
0); font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;" class=3D""><br style=3D"caret-color: rgb(0, 0, =
0); font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;" class=3D""><span style=3D"caret-color: rgb(0, 0, =
0); font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none; float: none; display: inline !important;" =
class=3D"">thanks,</span><br style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;" class=3D""><br style=3D"caret-color: rgb(0, 0, =
0); font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;" class=3D""><span style=3D"caret-color: rgb(0, 0, =
0); font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none; float: none; display: inline !important;" =
class=3D"">greg k-h</span></div></blockquote></div><br =
class=3D""></div></body></html>=

--Apple-Mail=_EC17D4B7-959B-4F5E-9BB0-64659F7F834B--

--===============2729248921982906517==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============2729248921982906517==--
