From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v3 0/9] Add PCI ATS support to Arm SMMUv3
Date: Tue, 23 Apr 2019 12:21:38 +0100
Message-ID: <20190423112138.GC3439@fuggles.cambridge.arm.com>
References: <20190417182448.12382-1-jean-philippe.brucker@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20190417182448.12382-1-jean-philippe.brucker@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Cc: lorenzo.pieralisi@arm.com, eric.auger@redhat.com, zhongmiao@hisilicon.com, okaya@kernel.org, joro@8bytes.org, rjw@rjwysocki.net, linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, iommu@lists.linux-foundation.org, hanjun.guo@linaro.org, sudeep.holla@arm.com, bhelgaas@google.com, robin.murphy@arm.com, linux-arm-kernel@lists.infradead.org, lenb@kernel.org
List-Id: iommu@lists.linux-foundation.org

On Wed, Apr 17, 2019 at 07:24:39PM +0100, Jean-Philippe Brucker wrote:
> This series enables PCI ATS in SMMUv3. Changes since v2 [1]:
> 
> * Fix build failure when building arm-smmu-v3 without CONFIG_PCI
>   Patches 1 and 2 are new.
> 
> * Only enable ATS if the root complex supports it. For the moment, only
>   IORT provides this information. I have patches for devicetree but
>   they are less mature and I'd rather make it a separate series.
> 
> * Tried to address most comments. I'll see if I can improve the firmware
>   code when adding devicetree support (see [2]).
> 
> Note that there is a small conflict with the SVA API. This series
> applies on top of Joerg's api-features branch for v5.2.

I'll pick this up via the SMMU queue, since the conflict with api-features
is trivial to resolve.

Will
