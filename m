From: David Ahern <dsahern@gmail.com>
Subject: Re: [PATCH 1/2] intel-iommu: Fix ACS path checking
Date: Sun, 05 Aug 2012 22:51:29 -0600
Message-ID: <501F4D51.9070306@gmail.com>
References: <20120804180155.6144.83332.stgit@bling.home> <20120804180852.6144.71902.stgit@bling.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <20120804180852.6144.71902.stgit@bling.home>
Sender: linux-pci-owner@vger.kernel.org
To: Alex Williamson <alex.williamson@redhat.com>
Cc: joerg.roedel@amd.com, dwmw2@infradead.org, iommu@lists.linux-foundation.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On 8/4/12 12:08 PM, Alex Williamson wrote:
> SR-IOV can create buses without a bridge.  There may be other cases
> where this happens as well.  In these cases skip to the parent bus
> and continue testing devices there.
>
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>

Tested-by: David Ahern <dsahern@gmail.com>
