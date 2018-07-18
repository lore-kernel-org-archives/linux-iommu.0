From: Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v4] dt-bindings: mediatek: Add binding for mt2712 IOMMU
	and SMI
Date: Wed, 18 Jul 2018 17:02:40 +0200
Message-ID: <d29f584b-30a8-0d2d-0ce2-9889907076c7@gmail.com>
References: <1527165331-22261-1-git-send-email-yong.wu@mediatek.com>
	<1529562433.22229.2.camel@mhfsdcap03>
	<d3d34d21-1a38-d3b7-1448-bd9e4c6afc6e@gmail.com>
	<20180718135446.GB18541@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180718135446.GB18541-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: arnd-r2nGTMty4D4@public.gmane.org, srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tomasz Figa <tfiga-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org



On 18/07/18 15:54, Joerg Roedel wrote:
> On Mon, Jul 16, 2018 at 03:28:14PM +0200, Matthias Brugger wrote:
>>>>  .../devicetree/bindings/iommu/mediatek,iommu.txt   |  6 +-
>>>>  .../memory-controllers/mediatek,smi-common.txt     |  6 +-
>>>>  .../memory-controllers/mediatek,smi-larb.txt       |  5 +-
>>>>  include/dt-bindings/memory/mt2712-larb-port.h      | 95 ++++++++++++++++++++++
>>>>  4 files changed, 106 insertions(+), 6 deletions(-)
>>>>  create mode 100644 include/dt-bindings/memory/mt2712-larb-port.h
>>>>
>>
>> Joerg, will you take this through your tree, or would you mind to provide a
>> Acked-By?
> 
> Sure,
> 
> 	Acked-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
> 

Thanks.
Pushed to v4.18-next/dts64
