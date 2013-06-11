From: Jassi Brar <jaswinder.singh@linaro.org>
Subject: Re: [PATCH 1/9] dma: pl330: rip out broken, redundant ID probing
Date: Tue, 11 Jun 2013 10:10:36 +0530
Message-ID: <CAJe_Zhc1UoTC4q4oaW=dzyi_10Q7EoezoT=G8_v+yCmBxV75+A@mail.gmail.com>
References: <1370889285-22799-1-git-send-email-will.deacon@arm.com>
 <1370889285-22799-2-git-send-email-will.deacon@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1370889285-22799-2-git-send-email-will.deacon@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Will Deacon <will.deacon@arm.com>
Cc: Vinod Koul <vinod.koul@intel.com>, iommu@lists.linux-foundation.org, device-tree <devicetree-discuss@lists.ozlabs.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: iommu@lists.linux-foundation.org

On 11 June 2013 00:04, Will Deacon <will.deacon@arm.com> wrote:
> The PL330 driver probes the peripheral and primecell IDs of the device to
> make sure that it is indeed an AMBA PL330. However, it does this by
> making byte accesses to a device mapping of the word-aligned ID
> registers, which is either UNPREDICTABLE or generates an alignment fault
> (depending on the presence of the virtualisation extensions).
>
> Rather than fix this code, we can actually rip most of it out and let
> the AMBA bus driver correctly do the probing for us.
>
Acked-by: Jassi Brar <jaswinder.singh@linaro.org>
