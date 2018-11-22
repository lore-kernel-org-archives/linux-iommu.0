From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v3 00/15] MT8183 IOMMU SUPPORT
Date: Thu, 22 Nov 2018 13:35:26 +0000
Message-ID: <20181122133526.GA13896@arm.com>
References: <1542422142-30688-1-git-send-email-yong.wu@mediatek.com>
	<20181122125931.GC1586@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20181122125931.GC1586-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
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
Cc: youlin.pei-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Nicolas Boichat <drinkcat-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, arnd-r2nGTMty4D4@public.gmane.org, srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tomasz Figa <tfiga-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Arvind Yadav <arvind.yadav.cs-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, yingjoe.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Thu, Nov 22, 2018 at 01:59:31PM +0100, Joerg Roedel wrote:
> On Sat, Nov 17, 2018 at 10:35:27AM +0800, Yong Wu wrote:
> > Yong Wu (14):
> >   dt-bindings: mediatek: Add binding for mt8183 IOMMU and SMI
> >   iommu/mediatek: Use a struct as the platform data
> >   memory: mtk-smi: Use a general config_port interface
> >   iommu/io-pgtable-arm-v7s: Add paddr_to_iopte and iopte_to_paddr
> >     helpers
> >   iommu/io-pgtable-arm-v7s: Extend MediaTek 4GB Mode
> >   iommu/mediatek: Add mt8183 IOMMU support
> >   iommu/mediatek: Add mmu1 support
> >   memory: mtk-smi: Invoke pm runtime_callback to enable clocks
> >   memory: mtk-smi: Use a struct for the platform data for smi-common
> >   memory: mtk-smi: Add bus_sel for mt8183
> >   iommu/mediatek: Add VLD_PA_RANGE register backup when suspend
> >   iommu/mediatek: Add shutdown callback
> >   memory: mtk-smi: Get rid of need_larbid
> >   iommu/mediatek: Switch to SPDX license identifier
> 
> This should probably go through the IOMMU tree. For that I'd like to
> have Acks (reviews are even better) for the io-pgtable parts from Robin
> and for the memory parts from Matthias first.

Robin already reviewed the pgtable bits, I think.

Will
