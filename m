From: Magnus Damm <magnus.damm@gmail.com>
Subject: Re: [PATCH] iommu/ipmmu-vmsa: Add r8a7795 DT binding
Date: Thu, 3 Mar 2016 00:46:30 +0900
Message-ID: <CANqRtoQQzav-kweM80NnVUqtr2xxaA95XV88U1Ye7yoYHzSUsA@mail.gmail.com>
References: <20160229143309.28517.77269.sendpatchset@little-apple>
	<20160302145559.GU22747@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20160302145559.GU22747@8bytes.org>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Pawel Moll <pawel.moll@arm.com>, "ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>, linux-renesas-soc@vger.kernel.org, iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>, Kumar Gala <galak@codeaurora.org>, Simon Horman <horms+renesas@verge.net.au>
List-Id: iommu@lists.linux-foundation.org

On Wed, Mar 2, 2016 at 11:55 PM, Joerg Roedel <joro@8bytes.org> wrote:
> On Mon, Feb 29, 2016 at 11:33:09PM +0900, Magnus Damm wrote:
>> From: Magnus Damm <damm+renesas@opensource.se>
>>
>> Update the IPMMU DT binding documentation to include the r8a7795 compat
>> string as well as the "renesas,ipmmu-main" property that on r8a7795 will
>> be used to describe the topology and the relationship between the various
>> cache IPMMU instances and the main IPMMU.
>>
>> Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
>> ---
>>
>>  Written against linux-next tag next-20160229
>>
>>  Documentation/devicetree/bindings/iommu/renesas,ipmmu-vmsa.txt |   15 ++++++++--
>>  1 file changed, 13 insertions(+), 2 deletions(-)
>
> Through which tree should this go?

Unless anyone objects may I suggest going through your tree please!

/ magnus
