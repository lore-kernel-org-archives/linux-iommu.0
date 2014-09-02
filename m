From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v3 3/3] iommu/arm-smmu: add support for
	DOMAIN_ATTR_NESTING	attribute
Date: Tue, 2 Sep 2014 12:16:26 +0100
Message-ID: <20140902111626.GJ25379@arm.com>
References: <1409651619-27342-1-git-send-email-will.deacon@arm.com>
	<1409651619-27342-4-git-send-email-will.deacon@arm.com>
	<6c60062d962340bbaeccb07c82eaae73@BL2PR03MB468.namprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <6c60062d962340bbaeccb07c82eaae73-AZ66ij2kwaacCcN9WK45f+O6mTEJWrR4XA4E9RH9d+qIuWR1G4zioA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Varun Sethi <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Tue, Sep 02, 2014 at 12:12:20PM +0100, Varun Sethi wrote:
> We would still need a mechanism to distinguish stage1 mapping from stage2
> mapping i.e. for nested translation we should be able to specify whether
> the mapping corresponds to stage1 or stage 2 translation. Also,
> correspondingly we would require different context banks for stage 1 and
> stage 2 translation.

Please take a look at my iommu/pci branch where I have much more support
for nested translation with the ARM SMMU driver. This series is purely about
getting the stage-2 part configured -- you need a virtual SMMU interface for
the stage-1 component.

Will
