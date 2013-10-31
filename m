From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH 3/5] iommu/arm-smmu: Use devm_ioremap_resource
Date: Thu, 31 Oct 2013 15:59:34 +0000
Message-ID: <20131031155933.GA30623@mudshark.cambridge.arm.com>
References: <1383217687-12037-1-git-send-email-tushar.behera@linaro.org>
 <1383217687-12037-4-git-send-email-tushar.behera@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1383217687-12037-4-git-send-email-tushar.behera@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tushar Behera <tushar.behera@linaro.org>
Cc: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, Joerg Roedel <joro@8bytes.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "patches@linaro.org" <patches@linaro.org>
List-Id: iommu@lists.linux-foundation.org

On Thu, Oct 31, 2013 at 11:08:05AM +0000, Tushar Behera wrote:
> While at it, propagate the error code.

Thanks, but I already have an equivalent patch queued which Joerg is going
to pull real soon now (right, Joerg? :p).

Will
