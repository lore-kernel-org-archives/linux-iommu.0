From: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 1/1] iommu/tegra: smmu: Fix deadly typo
Date: Thu, 25 Oct 2012 09:06:02 +0300
Message-ID: <20121025090602.6361b51a5c334bf0009af006@nvidia.com>
References: <1350538510-28356-1-git-send-email-hdoyu@nvidia.com>
	<20121024150121.GA2764@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="Multipart=_Thu__25_Oct_2012_09_06_02_+0300_WAG/Jq3Cxs78fXg9"
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20121024150121.GA2764-5C7GfCeVMHo@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Hiro Sugawara <hsugawara-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

--Multipart=_Thu__25_Oct_2012_09_06_02_+0300_WAG/Jq3Cxs78fXg9
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit

On Wed, 24 Oct 2012 17:01:21 +0200
Joerg Roedel <joerg.roedel-5C7GfCeVMHo@public.gmane.org> wrote:

> On Thu, Oct 18, 2012 at 08:35:10AM +0300, Hiroshi Doyu wrote:
> > From: Hiro Sugawara <hsugawara-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> > 
> > Fix a deadly typo in macro definition.
> > 
> > Signed-off-by: Hiro Sugawara <hsugawara-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> > Signed-off-by: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> 
> Applied, thanks.

Putting stable@ on To:. The original ptach attached.

--Multipart=_Thu__25_Oct_2012_09_06_02_+0300_WAG/Jq3Cxs78fXg9
Content-Type: message/rfc822
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

MIME-Version: 1.0
Received: from euowa.nvidia.com [10.21.70.99]
	by oreo with IMAP (fetchmail-6.3.19)
	for <hdoyu@localhost> (single-drop); Thu, 18 Oct 2012 09:07:18 +0300 (EEST)
Received: from hqemhub02.nvidia.com (172.20.150.31) by deemhub02.nvidia.com
 (10.21.69.138) with Microsoft SMTP Server (TLS) id 8.3.264.0; Thu, 18 Oct
 2012 07:35:29 +0200
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by hqemhub02.nvidia.com
 (172.20.150.31) with Microsoft SMTP Server id 8.3.264.0; Wed, 17 Oct 2012
 22:35:26 -0700
Received: from daphne.nvidia.com (Not Verified[172.16.212.96]) by
 hqnvemgw01.nvidia.com with MailMarshal (v6,7,2,8378)	id <B507f951f0000>; Wed,
 17 Oct 2012 22:35:27 -0700
Received: from oreo.Nvidia.com (dhcp-10-21-25-186.nvidia.com [10.21.25.186])
	by daphne.nvidia.com (8.13.8+Sun/8.8.8) with ESMTP id q9I5ZNMb029324;	Wed, 17
 Oct 2012 22:35:24 -0700 (PDT)
From: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
To: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>,
	"joerg.roedel-5C7GfCeVMHo@public.gmane.org" <joerg.roedel-5C7GfCeVMHo@public.gmane.org>
CC: "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Hiro Sugawara
	<hsugawara-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Date: Thu, 18 Oct 2012 07:35:10 +0200
Subject: [PATCH 1/1] iommu/tegra: smmu: Fix deadly typo
Thread-Topic: [PATCH 1/1] iommu/tegra: smmu: Fix deadly typo
Thread-Index: Ac2s8mKRe5w9gx27TpeD1sxz0GCYmQ==
Message-ID: <1350538510-28356-1-git-send-email-hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Accept-Language: en-US, en-CA, fi-FI
Content-Language: en-US
X-MS-Exchange-Organization-AuthAs: Internal
X-MS-Exchange-Organization-AuthMechanism: 10
X-MS-Exchange-Organization-AuthSource: hqemhub02.nvidia.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

From: Hiro Sugawara <hsugawara-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>

Fix a deadly typo in macro definition.

Signed-off-by: Hiro Sugawara <hsugawara-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Signed-off-by: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
 drivers/iommu/tegra-smmu.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index 94811fe..4167863 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -198,7 +198,7 @@ enum {
=20
 #define SMMU_ADDR_TO_PFN(addr)	((addr) >> 12)
 #define SMMU_ADDR_TO_PDN(addr)	((addr) >> 22)
-#define SMMU_PDN_TO_ADDR(addr)	((pdn) << 22)
+#define SMMU_PDN_TO_ADDR(pdn)	((pdn) << 22)
=20
 #define _READABLE	(1 << SMMU_PTB_DATA_ASID_READABLE_SHIFT)
 #define _WRITABLE	(1 << SMMU_PTB_DATA_ASID_WRITABLE_SHIFT)
--=20
1.7.5.4


--Multipart=_Thu__25_Oct_2012_09_06_02_+0300_WAG/Jq3Cxs78fXg9
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--Multipart=_Thu__25_Oct_2012_09_06_02_+0300_WAG/Jq3Cxs78fXg9--
